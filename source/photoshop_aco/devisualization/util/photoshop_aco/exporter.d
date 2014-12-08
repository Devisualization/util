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
module devisualization.util.photoshop_aco.exporter;
import devisualization.util.photoshop_aco.defs;

void exportData(ACOPalette _, out ubyte[] data) {
	uint offset = 0;
	writeData(_, data, 1, offset);
	writeData(_, data, 2, offset);
}

void addValue(ref ubyte[] data, ushort value) {
	import std.bitmanip : nativeToBigEndian;
	data ~= nativeToBigEndian(value);
}

void addValue(ref ubyte[] data, uint value) {
	import std.bitmanip : nativeToBigEndian;
	data ~= nativeToBigEndian(value);
}

void addValue(ref ubyte[] data, dstring value) {
	ubyte[] ret;
	foreach(c; value) {
		import std.bitmanip : nativeToBigEndian;
		ret ~= nativeToBigEndian(c);
	}
	ret ~= [0, 0]; // null term
	data ~= ret;
}

void writeData(ACOPalette _, ref ubyte[] data, ushort ver, ref uint offset) {
	data.addValue(ver);
	data.addValue(cast(ushort)_.colors.length);

	foreach(i, color; _.colors) {
		data.addValue(cast(ushort)0);
		data.addValue(color.r);
		data.addValue(color.g);
		data.addValue(color.b);
		data.addValue(0);

		if (ver == 2) {
			data.addValue(cast(uint)_.names[i].length);
			data.addValue(_.names[i]);
		}
	}
}