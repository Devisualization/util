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
module devisualization.util.photoshop_aco.defs;
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

	static ACOPalette parse(inout ubyte[] data) {
		import devisualization.util.photoshop_aco.loader;
		ACOPalette ret;
		ret.parseACO(data);
		return ret;
	}

	ubyte[] exportToData() {
		import devisualization.util.photoshop_aco.exporter;
		ubyte[] ret;
		exportData(this, ret);
		return ret;
	}
}