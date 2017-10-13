/**
 * Prevents modifications until x units have occured
 * 
 * License:
 *              Copyright Devisualization (Richard Andrew Cattermole) 2014 - 2017.
 *     Distributed under the Boost Software License, Version 1.0.
 *        (See accompanying file LICENSE_1_0.txt or copy at
 *              http://www.boost.org/LICENSE_1_0.txt)
 */
module devisualization.util.algorithms.modification_counter;

struct ModifierCounter(T) {
	private {
		T newValue;
		T currentValue;

		ushort counter;
		ushort counterSetTo;
	}

	this(ushort resetCounterTo) {
		counterSetTo = resetCounterTo;
	}

	@property {
		T get() {
			return currentValue;
		}

		void set(T v, bool immediate=false) {
			import std.traits : isPointer, isSomeFunction;
			newValue = v;

			if (immediate) {
				currentValue = newValue;
				counter = 0;
			} else {
				static if (isPointer!T || isSomeFunction!T) {
					if (currentValue !is v)
						counter = counterSetTo;
				} else {
					if (currentValue != v)
						counter = counterSetTo;
				}
			}
		}

		void mark() {
			if (counter >= 1) {
				counter--;
			} else {
				currentValue = newValue;
			}
		}
	}
}