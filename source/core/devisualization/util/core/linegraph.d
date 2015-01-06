/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2014 Devisualization (Richard Andrew Cattermole)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
module devisualization.util.core.linegraph;

/**
 * A line graph.
 * Given points produces all points upon the line.
 * 
 * Does not support decimal (float) points.
 * 
 * Could be rather useful for Devisualization.Image filters perhaps?
 */
struct LineGraphType(bool checkNegative, TYPE) {
	private {
		enum GraphFunction {
			BezierCurve,
			Line,
			Point
		}

		TYPE[] coordsx;
		TYPE[] coordsy;
		GraphFunction[] functions;

		TYPE[][] xPointBezierCurve;
		TYPE[][] yPointBezierCurve;
	}

	/**
	 * Initiate with starting point
	 * Acts as a lineTo
	 * 
	 * Params:
	 * 		startx	=	Starting x coord
	 * 		starty	=	Strating y coord
	 */
	this(TYPE startx = 0, TYPE starty = 0) {
		pointAt(startx, starty);
	}

	/**
	 * Adds a straight line.
	 * 
	 * Params:
	 * 		x	=	To position
	 * 		y	=	To position
	 */
	void lineTo(TYPE x, TYPE y) {
		coordsx ~= x;
		coordsy ~= y;
		functions ~= GraphFunction.Line;
	}

	/**
	 * Adds a posize_t line.
	 * 
	 * Params:
	 * 		x	=	To position
	 * 		y	=	To position
	 */
	void pointAt(TYPE x, TYPE y) {
		coordsx ~= x;
		coordsy ~= y;
		functions ~= GraphFunction.Point;
	}

	/**
	 * Adds a bezier curve.
	 * 
	 * Params:
	 * 		x		=	To position
	 * 		y		=	To position
	 * 		xPoints	=	Points to manipulate by
	 * 		yPoints	=	Points to manipulate by
	 */
	void bezierCurveTo(TYPE x, TYPE y, TYPE[] xPoints, TYPE[] yPoints) {
		coordsx ~= x;
		coordsy ~= y;
		functions ~= GraphFunction.BezierCurve;
		xPointBezierCurve ~= xPoints;
		yPointBezierCurve ~= yPoints;
	}

	/**
	 * Adds a bezier curve.
	 * 
	 * Params:
	 * 		x	=	To position
	 * 		y	=	To position
	 * 		x2	=	Posize_t to manipulate by
	 * 		y2	=	Posize_t to manipulate by
	 */
	void bezierCurveTo(TYPE x, TYPE y, TYPE x2, TYPE y2) {
		coordsx ~= x;
		coordsy ~= y;
		functions ~= GraphFunction.BezierCurve;
		xPointBezierCurve ~= [x2];
		yPointBezierCurve ~= [y2];
	}

	/**
	 * Get all points upon the line
	 * 
	 * Params:
	 * 		del		=	Delegate to call with a point
	 * 		step	=	The difference between points. Default: 1
	 */
	void apply(void delegate(TYPE x, TYPE y) del, size_t step = 1) {
		void d(TYPE x, TYPE y, float w) {
			del(x, y);
		}

		applyFunc!(checkNegative, TYPE)(this, &d, step);
	}

	/**
	 * Get all points upon the line
	 * Includes weighting for the point. Ranges from 0f .. 1f
	 * 
	 * Params:
	 * 		del		=	Delegate to call with a point
	 * 		step	=	The difference between points. Default: 1
	 */
	void apply(void delegate(TYPE x, TYPE y, float weighting) del, size_t step = 1) {
		applyFunc!(checkNegative, TYPE)(this, del, step);
	}
}

alias LineGraph = LineGraphType!(true, size_t);
alias SignedLineGraph = LineGraphType!(false, ptrdiff_t);

private {
	void applyFunc(bool checkNeg, TYPE, GRAPH)(GRAPH graph, void delegate(TYPE x, TYPE y, float w) del, size_t step = 1) {
		import std.math : floor, ceil, sin, cos, sqrt, PI, abs, pow;
		import std.algorithm : swap;

		with(graph) {
			TYPE lastx = coordsx[0];
			TYPE lasty = coordsy[0];
			size_t currentBezierCurve;
			del(lastx, lasty, 1f);

			foreach(i, func; functions) {
				TYPE x = coordsx[i];
				TYPE y = coordsy[i];
				
				TYPE newx = lastx;
				TYPE newy = lasty;

				if (func == GraphFunction.Line) {
					// http://en.wikipedia.org/wiki/Xiaolin_Wu%27s_line_algorithm
					// modified to force the start and end values to be 100% weighting

				 	void plot(TYPE xx, TYPE yy, float w) {
						// is pixel in range?
						// algo can go outside
						if (y > lasty && yy <= y && yy >= lasty) {
							if (x > lastx && xx <= x && xx >= lastx) {
								del(xx, yy, w);
							}
						}
					}

					TYPE ipart(float x) { return cast(TYPE)x; } // integer part of x
					TYPE round(float x) { return ipart(x + 0.5); }
					float fpart(float x) { return (x < 0) ?
						(1f - (x - x.floor)) :
						(x - x.floor); } // fractional part of x
					float rfpart(float x) { return 1 - fpart(x); }

					void drawLine(TYPE x0, TYPE y0, TYPE x1, TYPE y1) {
						bool steep = abs(y1 - y0) > abs(x1 - x0);
						if (steep) {
							swap(x0, y0);
							swap(x1, y1);
						}
						if (x0 > x1) {
							swap(x0, x1);
							swap(y0, y1);
						}

						TYPE dx = x1 - x0;
						TYPE dy = y1 - y0;
						float gradient = (cast(float)dy / cast(float)dx);

						// handle first endpoint
						TYPE xend = round(x0);
						float yend = y0 + gradient * (xend - x0);
						float xgap = rfpart(x0 + 0.5f);
						TYPE xpxl1 = xend; // this will be used in the main loop
						TYPE ypxl1 = ipart(yend);
						if (steep) {
							//plot(ypxl1, xpxl1, 1f); // doubled up
							plot(ypxl1+1, xpxl1, fpart(yend) * xgap);
						} else {
							//plot(xpxl1, ypxl1, 1f); // doubled up
							plot(xpxl1, ypxl1+1,  fpart(yend) * xgap);
						}
						float intery = yend + gradient; // first y-intersection for the main loop

						// handle second endpoint
						xend = round(x1);
						yend = y1 + gradient * (xend - x1);
						xgap = fpart(x1 + 0.5);
						TYPE xpxl2 = xend; //this will be used in the main loop
						TYPE ypxl2 = ipart(yend);
						if (steep) {
							plot(ypxl2, xpxl2, 1f);
							plot(ypxl2+1, xpxl2,  fpart(yend) * xgap);
						} else {
							plot(xpxl2, ypxl2,  rfpart(yend) * xgap);
							plot(xpxl2, ypxl2+1, 2f);
						}

						// main loop
						foreach(x; xpxl1 + 1 .. xpxl2) {
							if (steep) {
								plot(ipart(intery), x, rfpart(intery));
								plot(ipart(intery)+1, x, fpart(intery));
							} else {
								plot(x, ipart(intery), rfpart(intery));
								plot(x, ipart(intery)+1, fpart(intery));
							}
							intery += gradient * step;
						}
					}

					drawLine(lastx, lasty, x, y);
					lastx = x;
					lasty = y;
				} else if (func == GraphFunction.Point) {
					del(x, y, 1f);
					lastx = x;
					lasty = y;
				} else if (func == GraphFunction.BezierCurve) {
					//heavily based upon http://www.codeproject.com/Articles/25237/Bezier-Curves-Made-Simple

					TYPE[] xPoints = xPointBezierCurve[currentBezierCurve];
					TYPE[] yPoints = yPointBezierCurve[currentBezierCurve];
					xPoints = [lastx] ~ xPoints ~ [x];
					yPoints = [lasty] ~ yPoints ~ [y];

					currentBezierCurve++;

					double Ni(size_t n, size_t i) {
						import devisualization.util.core.math : factorial;

						double ni;
						double a1 = factorial(n);
						double a2 = factorial(i);
						double a3 = factorial(n - i);
						ni =  a1/ (a2 * a3);
						return ni;
					}

					double Bernstein(size_t n, size_t i, double t) {
						double basis;
						double ti; /* t^i */
						double tni; /* (1 - t)^i */
						  
						/* Prevent problems with pow */
								  
						if (t == 0.0 && i == 0) 
							ti = 1.0; 
						else 
							ti = pow(t, i);
						  
						if (n == i && t == 1.0) 
							tni = 1.0; 
						else 
							tni = pow((1 - t), (n - i));
						  
						//Bernstein basis
						basis = Ni(n, i) * ti * tni; 
						return basis;
					}

					void Bezier2D(size_t cpts) {
						size_t npts = xPoints.length;
						double t;
						double step2 = 1f / (cpts - 1);

			           	// Calculate points on curve
								  
		              	t = 0;
									  
		             	for (size_t j = 0; j < cpts; j++) { 
							if ((1.0 - t) < 5e-6) 
								t = 1.0;
								  
							double xout = 0;
							double yout = 0;

	                  		for (size_t k = 0; k < npts; k++) {
								double basis = Bernstein(npts - 1, k, t);
								xout += basis * xPoints[k];
								yout += basis * yPoints[k];
							}

							if (!(newx == cast(TYPE)xout && newy == cast(TYPE)yout))
								del(cast(TYPE)xout, cast(TYPE)yout, 1f);
							newx = cast(TYPE)xout;
							newy = cast(TYPE)yout;

							t += step2;
						}
					}

					size_t xPointsS;
					if (lastx > x)
						xPointsS = lastx - x;
					else
						xPointsS = x - lastx;
					size_t yPointsS;
					if (lasty > y)
						yPointsS = lasty - y;
					else
						yPointsS = y - lasty;
					Bezier2D(xPointsS * yPointsS);

					lastx = x;
					lasty = y;
				}
			}
		}
	}
}