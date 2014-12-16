module devisualization.util.core.linegraph;

/**
 * A line graph.
 * Given points produces all points upon the line.
 * 
 * Could be rather useful for Devisualization.Image filters perhaps?
 */
struct LineGraphType(bool checkNegative, TYPE) {
	private {
		enum GraphFunction {
			Arc,
			Line
		}

		TYPE[] coordsx;
		TYPE[] coordsy;
		GraphFunction[] functions;
		float[] arcRadius;
		TYPE[] arccoordsx;
		TYPE[] arccoordsy;
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
		lineTo(startx, starty);
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
	 * Adds an arc shape to the line.
	 * Can produce circles.
	 * 
	 * Params:
	 * 		x	=	To position
	 * 		y	=	To position
	 * 		cx	=	Center of arc's circle
	 * 		cy 	=	Center of arc's circle
	 */
	void arcTo(TYPE x, TYPE y, TYPE cx, TYPE cy) {
		import std.math : PI, sqrt, pow, abs;
		coordsx ~= x;
		coordsy ~= y;
		arccoordsx ~= cx;
		arccoordsy ~= cy;
		arcRadius ~= sqrt(cast(float)(cx.abs - x.abs).pow(2) + cast(float)(cy.abs - y.abs).pow(2));
		functions ~= GraphFunction.Arc;
	}

	/**
	 * Get all points upon the line
	 * 
	 * Params:
	 * 		del		=	Delegate to call with a point
	 * 		step	=	The difference between points. Default: 1
	 */
	void apply(void delegate(TYPE x, TYPE y) del, size_t step = 1) {
		applyFunc!(checkNegative, TYPE)(this, del, step);
	}
}

alias LineGraph = LineGraphType!(true, size_t);
alias SignedLineGraph = LineGraphType!(false, ptrdiff_t);
alias FloatingLineGraph = LineGraphType!(false, float);


private {
	void applyFunc(bool checkNeg, TYPE, GRAPH)(GRAPH graph, void delegate(TYPE x, TYPE y) del, size_t step = 1) {
		import std.math : floor, ceil, sin, cos, sqrt, PI;
		with(graph) {
			TYPE lastx = coordsx[0];
			TYPE lasty = coordsy[0];
			size_t arcsCount;
			import std.stdio;
			
			foreach(i, func; functions) {
				TYPE x = coordsx[i];
				TYPE y = coordsy[i];
				
				TYPE newx = lastx;
				TYPE newy = lasty;
				
				if (func == GraphFunction.Line) {
					del(lastx, lasty);
					if (x == lastx && y == lasty) {
					} else {
						float steepNess;
						steepNess = (y - lasty) / (x - lastx);
						
						if (newx <= x) {
							while(newx <= x) {
								newy = cast(TYPE)(steepNess * (newx-x) + y);
								
								del(newx, newy);
								newx += step;
							}
						} else if (newx >= x) {
							while(newx >= x) {
								newy = cast(TYPE)(steepNess * (newx-x) + y);
								del(newx, newy);

								bool cond = true;
								static if (checkNeg)
									cond = newx >= step && newy >= step;

								if (cond)
									newx -= step;
								else
									break;
							}
						}
					}
				} else if (func == GraphFunction.Arc) {
					float radius = arcRadius[arcsCount];
					TYPE cx = arccoordsx[arcsCount];
					TYPE cy = arccoordsy[arcsCount];
					
					float deg2rad(float value) {
						enum C = 180 / PI;
						return value / C;
					}
					
					float mystep = deg2rad(step / radius);
					float theta = 0;

					bool started = false;
					while(theta <= deg2rad(360)) {
						float tx = cx + radius * cos(theta);
						float ty = cy + radius * sin(theta);
						tx = tx < cx ? ceil(tx) : floor(tx);
						ty = ty < cy ? ceil(ty) : floor(ty);

						bool cond = true;
						static if (checkNeg)
							cond = tx >= step && ty >= step;

						if (cond) {
							TYPE myx = cast(TYPE)tx;
							TYPE myy = cast(TYPE)ty;
							
							if (myx == x && myy == y) {
								if (started) {
									lastx = x;
									lasty = y;
									break;
								}
							} else if (myx == lastx && myy == lasty) {
								if (started) {
									break;
								} else {
									started = true;
								}
							}
							
							if (started) {
								del(cast(TYPE)myx, cast(TYPE)myy);
							}
						}
						theta += mystep;
					}
					
					arcsCount++;
				}
			}
		}
	}
}