﻿module devisualization.photoshop_aco.defs;
import devisualization.image.color;

struct ACOPalette {
	package {
		Color_RGBA[] colors;
		dstring[] names;
	}

	@property {
		Color_RGBA lookup(string name) {
			import std.conv : to;
			return lookup(to!dstring(name));
		}

		Color_RGBA lookup(dstring name) {
			foreach(i, _; names) {
				if (_ == name)
					return colors[i];
			}

			return null;
		}

		dstring[] colorNames() {
			return names;
		}
	}

	void remove(string name) {
		import std.conv : to;
		remove(to!dstring(name));
	}

	void remove(dstring name) {
		Color_RGBA[] ncolors;
		dstring[] nnames;

		foreach(i, n; names) {
			if (n == name) {
			} else {
				ncolors ~= colors[i];
				nnames ~= n;
			}
		}

		colors = ncolors;
		names = nnames;
	}

	void opAssign(op)(Color_RGBA color, string name) {
		import std.conv : to;
		opAssign!"="(color, to!dstring(name));
	}

	void opAssign(op)(Color_RGBA color, dstring name) {
		static assert(op == "=");
		remove(name);
		colors ~= color;
		names ~= name;
	}

	static ACOPalette parse(ubyte[] data) {
		import devisualization.photoshop_aco.loader;
		ACOPalette ret;
		ret.parseACO(data);
		return ret;
	}

	ubyte[] exportToData() {
		import devisualization.photoshop_aco.exporter;
		ubyte[] ret;
		exportData(this, ret);
		return ret;
	}
}

void main() {
	import std.file : read, append, write;

	ubyte[] data = cast(ubyte[])read("test/Material Palette.aco");
	ACOPalette palette = ACOPalette.parse(data);

	write("out2.txt", "");
	foreach(color; palette.colors) {
		import std.conv : text;
		append("out2.txt", color.toString() ~ " = " ~ text(color.ubytes) ~ "\n");
	}
}