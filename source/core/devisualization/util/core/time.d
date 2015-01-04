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
module devisualization.util.core.time;
import std.datetime : SysTime, Clock;
import core.time : Duration;

/**
 * UTC+0 time
 */

@property {
	/**
	 * Gets the current time without any offsets.
	 * 
	 * Returns:
	 * 		The time (UNIX) without any offsets.
	 */
	ulong utc0Time() {
		return utc0SysTime().toUnixTime();
	}

	/**
	 * Gets the current time without any offsets.
	 * 
	 * Returns:
	 * 		The time without any offsets.
	 */
	SysTime utc0SysTime() {
		return Clock.currTime().removeOffset;
	}

	/**
	 * Gets the time this application was compiled without any offsets.
	 * 
	 * Returns:
	 * 		The time (UNIX) without any offsets.
	 */
	ulong utc0Compiled() {
		return utc0CompiledSysTime().toUnixTime();
	}

	/**
	 * Gets the time this application was compiled without any offsets.
	 * 
	 * Returns:
	 * 		The time without any offsets.
	 */
	SysTime utc0CompiledSysTime() {
		import devisualization.util.core.text : replace, split;
		string timestamp = __TIMESTAMP__.replace("  ", " ");
		string[] values = timestamp.split(" ");
		
		string timeo;
		timeo ~= values[4] ~ "-";
		timeo ~= values[1] ~ "-";
		
		if (values[2].length == 1)
			timeo ~= "0";
		timeo ~= values[2] ~ " ";
		
		timeo ~= values[3];

		return SysTime.fromSimpleString(timeo).removeOffset;
	}
}

/**
 * Removes the offset on a time object
 */
SysTime removeOffset(SysTime time) {
	time -= time.utcOffset;
	return time;
}

private {
	string utc0CompiledTimeStamp() {
		import devisualization.util.core.text : split;
		import std.conv : to;
		import std.string : toUpper;
		auto time = utc0CompiledSysTime();
		
		string dayOfWeek = to!string(time.dayOfWeek);
		string month = to!string(time.month);
		dayOfWeek = cast(char)toUpper(dayOfWeek[0]) ~ dayOfWeek[1 .. $];
		month = cast(char)toUpper(month[0]) ~ month[1 .. $];
		
		string output;
		output ~= dayOfWeek ~ ", ";
		output ~= to!string(time.day) ~ " ";
		output ~= month ~ " ";
		output ~= to!string(time.year) ~ " ";
		output ~= time.toSimpleString().split(" ")[1] ~ " GMT";
		
		return output;
	}
}