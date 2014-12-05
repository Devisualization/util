module devisualization.photoshop_aco.loader;
import devisualization.photoshop_aco.defs;

void parseACO(ACOPalette _, ubyte[] data) {
	uint offset = 0;

	if (data.getValue(offset) == 1) {
		offset = readData(_, data);
	}

	if (data.getValue(offset) == 2) {
		readData(_, data, offset);
	}
}

ushort getValue(ubyte[] data, uint index) {
	import std.bitmanip : bigEndianToNative;

	uint start = index * 2;
	ubyte[2] values = data[start .. start + 2];

	return bigEndianToNative!ushort(values);
}

uint getValueInt(ubyte[] data, uint index) {
	import std.bitmanip : bigEndianToNative;
	
	uint start = index * 2;
	ubyte[4] values = data[start .. start + 4];
	
	return bigEndianToNative!uint(values);
}

uint readData(ACOPalette _, ubyte[] data, uint j = 0) {
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
			foreach(k; j .. j + length) {
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