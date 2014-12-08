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
module devisualization.util.photoshop_aco.loader;
import devisualization.util.photoshop_aco.defs;

void parseACO(ref ACOPalette _, inout ubyte[] data) {
	uint offset = 0;

	if (data.getValue(offset) == 1) {
		offset = readData(_, data);
	}

	if (data.getValue(offset) == 2) {
		readData(_, data, offset);
	}
}

ushort getValue(inout ubyte[] data, uint index) {
	import std.bitmanip : bigEndianToNative;

	uint start = index * 2;
	ubyte[2] values = data[start .. start + 2];

	return bigEndianToNative!ushort(values);
}

uint getValueInt(inout ubyte[] data, uint index) {
	import std.bitmanip : bigEndianToNative;
	
	uint start = index * 2;
	ubyte[4] values = data[start .. start + 4];
	
	return bigEndianToNative!uint(values);
}

uint readData(ref ACOPalette _, inout ubyte[] data, uint j = 0) {
	import devisualization.image.color;
	ushort ver = data.getValue(j);

	ushort count = data.getValue(j + 1);
	j += 2;

	for(uint i = 0; i < count; i++) {
		if (ver == 2) {
			j += 5;

			uint length = data.getValueInt(j);
			j += 2;

			dstring text;
			foreach(k; j .. j + length - 1) {
				text ~= cast(dchar)data.getValue(k);
			}

			_.names ~= text;

			j += length;
		} else if (ver == 1) {
			ushort color_space = data.getValue(j);
			ushort w = data.getValue(j + 1);
			ushort x = data.getValue(j + 2);
			ushort y = data.getValue(j + 3);
			ushort z = data.getValue(j + 4);
			
			if (color_space == 0) {
				_.colors ~= new Color_RGBA(w, x, y, ushort.max);
			} else {
				throw new Exception("Unknown color space");
			}
			
			j += 5;
		}
	}

	return j;
}