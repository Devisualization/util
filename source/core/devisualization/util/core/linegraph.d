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
deprecated("Use PointsGenerator instead.")
struct LineGraphType(bool checkNegative, TYPE) {
    private {
        enum GraphFunction {
            SplineCurve,
            BezierCurve,
            Line,
            Point
        }

        TYPE[] coordsx;
        TYPE[] coordsy;
        GraphFunction[] functions;

        TYPE[][] xPointBezierCurve;
        TYPE[][] yPointBezierCurve;
        float[] splineCurveTensions;
    }

    /**
     * Initiate with starting point
     * Acts as a lineTo
     * 
     * Params:
     *         startx    =    Starting x coord
     *         starty    =    Strating y coord
     */
    this(TYPE startx = 0, TYPE starty = 0) {
        pointAt(startx, starty);
    }

    /**
     * Adds a straight line.
     * 
     * Params:
     *         x    =    To position
     *         y    =    To position
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
     *         x    =    To position
     *         y    =    To position
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
     *         x        =    To position
     *         y        =    To position
     *         xPoints  =    Points to manipulate by
     *         yPoints  =    Points to manipulate by
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
     *         x    =    To position
     *         y    =    To position
     *         x2   =    Point to manipulate by
     *         y2   =    Point to manipulate by
     */
    void bezierCurveTo(TYPE x, TYPE y, TYPE x2, TYPE y2) {
        coordsx ~= x;
        coordsy ~= y;
        functions ~= GraphFunction.BezierCurve;
        xPointBezierCurve ~= [x2];
        yPointBezierCurve ~= [y2];
    }
    
    /**
     * Adds a bezeier curve using points to derive the control points
     * 
     * Params:
     *         x        =    To position
     *         y        =    To position
     *         x2       =    Point to go through
     *         y2       =    Point to go through
     *         tension  =    Tension for the curve
     */
    void splineThrough(TYPE x, TYPE y, TYPE x2, TYPE y2, float tension) {
        coordsx ~= x;
        coordsy ~= y;
        functions ~= GraphFunction.SplineCurve;
        xPointBezierCurve ~= [x2];
        yPointBezierCurve ~= [y2];
        splineCurveTensions ~= tension;
    }

    /**
     * Get all points upon the line
     * 
     * Params:
     *         del     =    Delegate to call with a point
     *         step    =    The difference between points. Default: 1
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
     *         del     =    Delegate to call with a point
     *         step    =    The difference between points. Default: 1
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
            size_t currentBezierCurve, currentSpline;
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
						// FIXME:
                        /*if (y > lasty && yy <= y && yy >= lasty) {
                            if (x > lastx && xx <= x && xx >= lastx) {
                                del(xx, yy, w);
                            }
                        }*/
						del(xx, yy, w);
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
                } else if (func == GraphFunction.BezierCurve || func == GraphFunction.SplineCurve) {
                    //heavily based upon http://www.codeproject.com/Articles/25237/Bezier-Curves-Made-Simple

                    TYPE[] xPoints = xPointBezierCurve[currentBezierCurve];
                    TYPE[] yPoints = yPointBezierCurve[currentBezierCurve];
                    
                    if (func == GraphFunction.SplineCurve) {
                        TYPE[] xPoints2;
                        TYPE[] yPoints2;
                        xPoints2.length = xPoints.length + 1;
                        yPoints2.length = yPoints.length + 1;
                        
                        float tension = splineCurveTensions[currentSpline];
                        
                        size_t poi;
                        foreach(j, xp; xPoints) {
                            TYPE yp = yPoints[j];
                            TYPE xpp, ypp;
                            
                            if (j == xPoints.length - 1) {
                                xpp = x;
                                ypp = y;
                            } else {
                                xpp = x;
                                ypp = y;
                            }
                                
                            auto splineControlPoints = getSplineControlPoints(lastx, lasty, xp, yp, xpp, ypp, tension);
                            xPoints2[poi] = splineControlPoints[0];
                            yPoints2[poi] = splineControlPoints[1];
                            xPoints2[poi + 1] = splineControlPoints[2];
                            yPoints2[poi + 1] = splineControlPoints[3];
                            
                            poi += 2;
                        }
                        
                        xPoints = [lastx] ~ xPoints2 ~ [x];
                        yPoints = [lasty] ~ yPoints2 ~ [y];
                        currentSpline++;
                    } else {
                        xPoints = [lastx] ~ xPoints ~ [x];
                        yPoints = [lasty] ~ yPoints ~ [y];
                    }

                    currentBezierCurve++;

                    double Ni(size_t n, size_t i) {
                        import devisualization.util.core.math : factorial;

                        double ni;
                        double a1 = factorial(n);
                        double a2 = factorial(i);
                        double a3 = factorial(n - i);
                        ni = a1 / (a2 * a3);
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

    TYPE[4] getSplineControlPoints(TYPE)(TYPE x0, TYPE y0, TYPE x1, TYPE y1, TYPE x2, TYPE y2, float t){
        // from http://scaledinnovation.com/analytics/splines/aboutSplines.html
        import std.math : sqrt, pow;
        
        real d01 = sqrt(pow(x1 - x0, 2f) + pow(y1 - y0, 2f));
        real d12 = sqrt(pow(x2 - x1, 2f) + pow(y2 - y1, 2f));
        real fa = t * d01 / (d01 + d12);                   // scaling factor for triangle Ta
        real fb = t * d12 / (d01 + d12);                   // ditto for Tb, simplifies to fb=t-fa
        TYPE p1x = cast(TYPE)(x1 - fa * (x2 - x0));        // x2-x0 is the width of triangle T
        TYPE p1y = cast(TYPE)(y1 - fa * (y2 - y0));        // y2-y0 is the height of T
        TYPE p2x = cast(TYPE)(x1 + fb * (x2 - x0));
        TYPE p2y = cast(TYPE)(y1 + fb * (y2 - y0));  
        return [p1x, p1y, p2x, p2y];
    }
}

/**
 * A line graph.
 * Given points produces all points upon the line.
 * 
 * Uses the GC.
 */
struct PointsGenerator(Point) if (__traits(compiles, {
			Point p;
			double
				x = p.x,
				y = p.y,
				z = p.z;
			p.x = x;
			p.y = y;
			p.z = z;
	})) {

	private {
		Segment!Point[] segments;
		Point startAt;
	}
	
	this(Point startAt) {
		import std.math : isNaN;
		
		if (startAt.x.isNaN)
			startAt.x = 0;
		if (startAt.y.isNaN)
			startAt.y = 0;
		if (startAt.z.isNaN)
			startAt.z = 0;
		
		this.startAt = startAt;
	}
	
	void pointAt(Point location) {
		import std.math : isNaN;
		
		if (location.x.isNaN)
			location.x = 0;
		if (location.y.isNaN)
			location.y = 0;
		if (location.z.isNaN)
			location.z = 0;
		
		segments ~= Segment!Point(Segment!Point.Type.Point, location);
	}
	
	void lineTo(Point location) {
		import std.math : isNaN;
		
		if (location.x.isNaN)
			location.x = 0;
		if (location.y.isNaN)
			location.y = 0;
		if (location.z.isNaN)
			location.z = 0;
		
		segments ~= Segment!Point(Segment!Point.Type.LineTo, location);
	}
	
	void bezierOf(Point location, Point[] control...) {
		if (control.length == 0) {
			// basically is a straight line,
			// but bezier curve evaluation is slow compared to lineTo.
			lineTo(location);
			// hence we switch to it instead.
		} else {
			segments ~= Segment!Point(Segment!Point.Type.Bezier, location);
			segments[$-1].bezier_points = control.dup;
		}
	}
	
	void arcOf(Point location, Point arc_radius) {
		segments ~= Segment!Point(Segment!Point.Type.Arc, location);
		segments[$-1].arc_radius = arc_radius;
	}
	
	auto generate(double interval) {
		struct Result {
			Segment!Point[] segments;
			immutable(double) interval;
			Point next, current;
			
			this(Segment!Point[] segments, double interval, Point startAt) {
				this.segments = segments;
				this.interval = interval;
				next = startAt;
				
				if (segments.length > 0)
					segments[0].initialize(interval, next);
				next = startAt;
			}
			
			@property {
				pragma(inline, true)
				Point front() {
					return next;
				}
				
				pragma(inline, true)
				bool empty() {
					return segments.length == 0 || next == Point.init;
				}
			}
			
			void popFront() {
				import std.math : isNaN;
				current = next;
				next = Point.init;
				
				while(segments.length > 0) {
					Point ret = segments[0].nextCoord(interval, current);
					
					if (ret.x.isNaN || ret.y.isNaN || ret.z.isNaN) {
						segments = segments[1 .. $];
						if (segments.length > 0)
							segments[0].initialize(interval, current);
					} else {
						next = ret;
						break;
					}
				}
			}
		}
		
		return Result(segments.dup, interval, startAt);
	}
}

private {
	struct Segment(Point) {
		Type type;
		Point location, arc_radius;
		Point[] bezier_points;
		
		void initialize(double interval, ref Point previous) {
			import std.math : abs, copysign, pow, PI, PI_2, sqrt;
			
			switch(type) {
				case Type.LineTo:
					dx = location.x - previous.x;
					dy = location.y - previous.y;
					dz = location.z - previous.z;
					
					Point point_abs = Point(abs(dx), abs(dy), abs(dz));
					double point_sum_third = (point_abs.x + point_abs.y + point_abs.z) * (1/3f);
					Point point_portion = Point(
						point_abs.x / point_sum_third,
						point_abs.y / point_sum_third,
						point_abs.z / point_sum_third);
					
					lineTo_delta = Point(
						copysign(point_portion.x, dx) * interval,
						copysign(point_portion.y, dy) * interval,
						copysign(point_portion.z, dz) * interval);
					break;
					
				case Type.Arc:
					// This code is surprisingly like lineTo.
					
					// Required to calculate starting angles (to the quartent) of the curve.
					//  in lineTo it only needs 'effective' difference, where as here we
					//  need full correct difference with understanding of negatives.
					dx = calculateDifferenceOnAxis(location.x, previous.x);
					dy = calculateDifferenceOnAxis(location.y, previous.y);
					dz = calculateDifferenceOnAxis(location.z, previous.z);
					
					arc_center = Point(
						(location.x + previous.x)/2,
						(location.y + previous.y)/2,
						(location.z + previous.z)/2);
					arc_radius = Point(
						abs(arc_center.x-location.x),
						abs(arc_center.y-location.y),
						abs(arc_center.z-location.z));
					
					double train_error1, train_error2,
						current_angle1, current_angle2;
					
					// x
					
					if (dx > 0) {
						current_angle1 = PI;
						current_angle2 = PI+PI_2;
					} else {
						current_angle1 = 0;
						current_angle2 = PI_2;
					}
					
					train_error1 = 0;
					train_error2 = 0;
					
					while(train_NN(current_angle1, train_error1, 0.1, arc_radius.x, arc_center.x, previous.x)) {}
					while(train_NN(current_angle2, train_error2, 0.1, arc_radius.x, arc_center.x, location.x)) {}
					
					if (current_angle1 > current_angle2 && dx > 0) {
						arc_angle.x = (2*PI) - current_angle1;
						arc_maxangle.x = (2*PI) - current_angle2;
					} else {
						arc_angle.x = current_angle1;
						arc_maxangle.x = current_angle2;
					}
					
					// x
					// y
					
					if (dy > 0) {
						current_angle1 = PI;
						current_angle2 = PI+PI_2;
					} else {
						current_angle1 = 0;
						current_angle2 = PI_2;
					}
					
					train_error1 = 0;
					train_error2 = 0;
					
					while(train_NN(current_angle1, train_error1, 0.1, arc_radius.y, arc_center.y, previous.y)) {}
					while(train_NN(current_angle2, train_error2, 0.1, arc_radius.y, arc_center.y, location.y)) {}
					
					if (current_angle1 > current_angle2 && dy > 0) {
						arc_angle.y = (2*PI) - current_angle1;
						arc_maxangle.y = (2*PI) - current_angle2;
					} else {
						arc_angle.y = current_angle1;
						arc_maxangle.y = current_angle2;
					}
					
					// y
					// z
					
					if (dz > 0) {
						current_angle1 = PI;
						current_angle2 = PI+PI_2;
					} else {
						current_angle1 = 0;
						current_angle2 = PI_2;
					}
					
					train_error1 = 0;
					train_error2 = 0;
					
					while(train_NN(current_angle1, train_error1, 0.1, arc_radius.z, arc_center.z, previous.z)) {}
					while(train_NN(current_angle2, train_error2, 0.1, arc_radius.z, arc_center.z, location.z)) {}
					
					if (current_angle1 > current_angle2 && dz > 0) {
						arc_angle.z = (2*PI) - current_angle1;
						arc_maxangle.z = (2*PI) - current_angle2;
					} else {
						arc_angle.z = current_angle1;
						arc_maxangle.z = current_angle2;
					}
					
					// z
					
					double angle_sum_third = (abs(dx)+abs(dy)+abs(dz))*(1/3f);
					Point angle_diff = Point(
						arc_maxangle.x-arc_angle.x,
						arc_maxangle.y-arc_angle.y,
						arc_maxangle.z-arc_angle.z);
					arc_delta = Point(
						copysign(angle_diff.x / angle_sum_third, angle_diff.x) * interval,
						copysign(angle_diff.y / angle_sum_third, angle_diff.y) * interval,
						copysign(angle_diff.z / angle_sum_third, angle_diff.z) * interval);
					
					arc_angle.x += arc_delta.x;
					arc_angle.y += arc_delta.y;
					arc_angle.z += arc_delta.z;
					break;
					
				case Type.Bezier:
					bezier_buffer.length = bezier_points.length+2;
					origin_point = previous;
					
					// Our goal for getting the number of ticks to operate for
					//  is to determine essentially the length of the line.
					// Unfortunately this goal is impossible to do.
					// So we do things a bit more evilly.
					
					// And truth is, I don't care too much about it.
					// What I care about is figuring out a tick count that will work for all of the arc's.
					
					// Each bezier curve exists in a 0f..1f space.
					// But we have three axis to work upon, not two.
					// What we want to archive is to get the difference between each control point,
					//  is to be roughly the length of interval.
					// Because of this, we treat each arc seperately,
					//  the distance we want, is (bestDistance/arcs.length) == interval
					//  we know that it won't be possible to get this to occur,
					//  but we want to get as close to it as we can.
					
					double
						bestDistance = double.max_exp,
						bestTickCount = 1,
						expectedDistance = interval*(bezier_points.length+1),
						tickCount=1;
					
					foreach(i; 0 .. 60) {
						// 0..4 = 1
						// 4..8 = 0.1
						// 8..12 = 0.01
						double
							learnRate =
								i < 20 ? interval :
								i < 40 ? interval / 10 :
								interval / 100;
						Point sum = Point(0, 0, 0);
						
						foreach(j; 0 .. 2) {
							double tickIndevidual = 1f/tickCount;
							double tick = j == 0 ? tickIndevidual : (2f/tickCount);
							Point startPoint = previous;
							
							foreach(p; bezier_points) {
								sum.x += bezier_combine(startPoint.x, p.x, tick+tickIndevidual)-bezier_combine(startPoint.x, p.x, tick);
								sum.y += bezier_combine(startPoint.y, p.y, tick+tickIndevidual)-bezier_combine(startPoint.y, p.y, tick);
								sum.z += bezier_combine(startPoint.z, p.z, tick+tickIndevidual)-bezier_combine(startPoint.z, p.z, tick);
								
								startPoint = p;
							}
							
							sum.x += bezier_combine(startPoint.x, location.x, tick+tickIndevidual)-bezier_combine(startPoint.x, location.x, tick);
							sum.y += bezier_combine(startPoint.y, location.y, tick+tickIndevidual)-bezier_combine(startPoint.y, location.y, tick);
							sum.z += bezier_combine(startPoint.z, location.z, tick+tickIndevidual)-bezier_combine(startPoint.z, location.z, tick);
						}
						
						double sumV = (sum.x+sum.y+sum.z)/6;
						if (bestDistance - expectedDistance > sumV-expectedDistance) {
							bestDistance = sumV;
							bestTickCount = tickCount;
						} else {
							tickCount += tickCount * learnRate * (sumV / expectedDistance);
						}
					}
					
					bezier_tick = 1f/(bestTickCount/2);
					bezier_bezierOffset = bezier_tick;
					break;
					
				default:
					break;
			}
		}
		
		double dx, dy, dz;
		Point origin_point;
		union {
			struct {
				double[] bezier_buffer;
				double bezier_tick,
					bezier_bezierOffset;
			}
			
			struct {
				Point arc_delta,
					arc_center,
					arc_maxangle,
					arc_angle;
			}
			Point lineTo_delta;
		}
		
		Point nextCoord(double interval, ref Point previous) {
			switch(type) {
				case Type.Point:
					scope(exit) location = Point.init;
					return location;
					
				case Type.LineTo:
					if ((dx > 0 && previous.x >= location.x) || (dx < 0 && previous.x <= location.x) ||
						(dy > 0 && previous.y >= location.y) || (dy < 0 && previous.y <= location.y) ||
						(dz > 0 && previous.z >= location.z) || (dz < 0 && previous.z <= location.z))
						return Point.init;
					else {
						Point ret = Point(
							previous.x + lineTo_delta.x,
							previous.y + lineTo_delta.y,
							previous.z + lineTo_delta.z);
						
						if ((dx > 0 && ret.x >= location.x) || (dx < 0 && ret.x <= location.x))
							ret.x = location.x;
						if ((dy > 0 && ret.y >= location.y) || (dy < 0 && ret.y <= location.y))
							ret.y = location.y;
						if ((dz > 0 && ret.z >= location.z) || (dz < 0 && ret.z <= location.z))
							ret.z = location.z;
						
						return ret;
					}
					
				case Type.Arc:
					import std.math : cos, sin;
					
					if (arc_angle.x >= arc_maxangle.x ||
						arc_angle.y >= arc_maxangle.y ||
						arc_angle.z >= arc_maxangle.z	)
						return Point.init;
					
					Point ret = Point(
						(arc_radius.x * cos(arc_angle.x)) + arc_center.x,
						(arc_radius.y * cos(arc_angle.y)) + arc_center.y,
						(arc_radius.z * cos(arc_angle.z)) + arc_center.z);
					
					arc_angle.x += arc_delta.x;
					arc_angle.y += arc_delta.y;
					arc_angle.z += arc_delta.z;
					
					if (arc_angle.x >= arc_maxangle.x)
						ret.x = location.x;
					if (arc_angle.y >= arc_maxangle.y)
						ret.y = location.y;
					if (arc_angle.z >= arc_maxangle.z)
						ret.z = location.z;
					
					return ret;
					
				case Type.Bezier:
					import std.math : ceil;
					
					if (bezier_bezierOffset >= 1f)
						return Point.init;
					
					Point ret;
					
					//
					
					bezier_buffer[0] = origin_point.x;
					bezier_buffer[$-1] = location.x;
					foreach(i, p; bezier_points)
						bezier_buffer[1+i] = p.x;
					
					bezier_handle(bezier_buffer.length, bezier_buffer, bezier_bezierOffset);
					ret.x = bezier_buffer[0];
					
					//
					
					bezier_buffer[0] = origin_point.y;
					bezier_buffer[$-1] = location.y;
					foreach(i, p; bezier_points)
						bezier_buffer[1+i] = p.y;
					
					bezier_handle(bezier_buffer.length, bezier_buffer, bezier_bezierOffset);
					ret.y = bezier_buffer[0];
					
					//
					
					bezier_buffer[0] = origin_point.z;
					bezier_buffer[$-1] = location.z;
					foreach(i, p; bezier_points)
						bezier_buffer[1+i] = p.z;
					
					bezier_handle(bezier_buffer.length, bezier_buffer, bezier_bezierOffset);
					ret.z = bezier_buffer[0];
					
					///
					
					bezier_bezierOffset += bezier_tick;
					
					if (bezier_bezierOffset >= 1f) {
						ret.x = location.x;
						ret.y = location.y;
						ret.z = location.z;
					}
					return ret;
					
				default:
					return Point.init;
			}
		}
		
		enum Type {
			Error,
			Point,
			LineTo,
			Bezier,
			Arc
		}
	}
	
	double bezier_combine(double a, double b, double t) {
		return (a*(1-t)) + (b*t);
	}
	
	void bezier_handle(size_t recurseIndex, double[] bezier_buffer, double bezier_bezierOffset) {
		while(recurseIndex > 1) {
			uint newIndex;
			foreach(actualIndex; 1 .. recurseIndex) {
				double
					a = bezier_buffer[actualIndex-1],
					b = bezier_buffer[actualIndex];
				bezier_buffer[newIndex] = bezier_combine(a, b, bezier_bezierOffset);
				newIndex++;
			}
			
			recurseIndex = newIndex;
		}
	}
	
	bool train_NN(ref double cangle, ref double error, double train_rate, double radius, double center, double v) {
		import std.math : cos, PI, abs;
		
		error = (radius*cos(cangle)+center)-v;
		cangle += error*train_rate;
		return abs(error) > train_rate;
	}
	
	double calculateDifferenceOnAxis(double a, double b) {
		import std.math : abs, copysign;
		
		if (a >= 0 && b >= 0) {
		} else if (a <= 0 && b <= 0) {
		} else if (a > b) {
			return abs(b)+a;
		} else {
			return -(abs(a)+b);
		}
		
		return a-b;
	}
}