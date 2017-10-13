/**
 * License:
 *              Copyright Devisualization (Richard Andrew Cattermole) 2014 - 2017.
 *     Distributed under the Boost Software License, Version 1.0.
 *        (See accompanying file LICENSE_1_0.txt or copy at
 *              http://www.boost.org/LICENSE_1_0.txt)
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