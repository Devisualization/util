module devisualization.photoshop_aco.defs;
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

	static ACOPalette parse(ubyte[] data) {
		import devisualization.photoshop_aco.loader;
		ACOPalette ret;
		ret.parseACO(data);
		return ret;
	}
}