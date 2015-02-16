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
module devisualization.util.algorithms.bunnyhop;
import gl3n.linalg : vec3, dot;

/**
 * Based upon http://flafla2.github.io/2015/02/14/bunnyhop.html
 */
 struct BunnyHopSpeed {
	private {
		vec3 previousVelocity;
		float airAccel, airMaxAccel, groundAccel, groundMaxAccel;
		
		ubyte friction;
		float timeUnit;
	}
 
	/**
	 * Base data for a bunny hop calculations
	 *
	 * Params:
	 * 		friction			=	The friction of the world. Must be between 1 and 5. Where 5 would cause gliding.
	 *		airAccel			=	Acceleration speed while in the air (e.g. jumps)
	 *		airMaxAccel			= 	The maximum acceleration in the air (e.g. jumps)
	 *		groundAccel			=	Acceleration speed while on the ground
	 *		groundMaxAccel		=	The maximum acceleration on the ground
	 * 		timeUnit			=	How long is a single time unit aka per frame? Default: 1
	 *		previousVelocity	=	What was the previous velocity that the character was at? Default: X: 0, Y: 0, Z: 0
	 */
	this(ubyte friction, float airAccel, float airMaxAccel, float groundAccel, float groundMaxAccel, float timeUnit = 1f, vec3 previousVelocity = vec3(0, 0, 0))
	in {
		assert(friction >= 1 && friction <= 5);
	} body {
		this.friction = friction;
		this.timeUnit = timeUnit;
		
		this.airAccel = airAccel;
		this.airMaxAccel = airMaxAccel;
		this.groundAccel = groundAccel;
		this.groundMaxAccel = groundMaxAccel;
		
		this.previousVelocity = previousVelocity;
	}
	
	/**
	 * Gets the current velocity and updates it to be the previous one
	 *
	 * Params:
	 *		accelDir	=	The direction the player has specified (e.g. arrow keys)
	 *		inAir		=	Is the player currently in the air? Default: false
	 *
	 * Returns:
	 * 		The current velocity
	 */
	vec3 newVelocity(vec3 accelDir, bool inAir = false) {
		import std.math : fmax;
		vec3 ret;
		
		if (inAir) {
			ret = accelerate(accelDir, airAccel, airMaxAccel);
		} else {
			float speed = cast(float)previousVelocity.magnitude;
			
			if (speed != 0) {
				float drop = speed * friction * timeUnit;
				previousVelocity *= fmax(speed - drop, 0f) / speed;
			}
			
			ret = accelerate(accelDir, groundAccel, groundMaxAccel);
		}
		
		previousVelocity = ret;
		return ret;
	}
	
	private vec3 accelerate(vec3 accelDir, float accelerate, float max_velocity) {
		float projVel = dot(previousVelocity, accelDir);
		float accelVel = accelerate * timeUnit;
		
		if (projVel + accelVel > max_velocity)
			accelVel = max_velocity - projVel;
		
		return previousVelocity + accelDir * accelVel;
	}
 }