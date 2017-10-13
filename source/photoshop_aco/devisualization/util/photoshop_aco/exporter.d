/**
 * License:
 *              Copyright Devisualization (Richard Andrew Cattermole) 2014 - 2017.
 *     Distributed under the Boost Software License, Version 1.0.
 *        (See accompanying file LICENSE_1_0.txt or copy at
 *              http://www.boost.org/LICENSE_1_0.txt)
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