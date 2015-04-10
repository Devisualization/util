/**
 * Prevents modifications until x units have occured
 *
 * License:
 *     D version of code is under MIT. The original is under Apache 2.0.
 * 
 *     The MIT License (MIT)
 *
 *     Copyright (c) 2014 Devisualization (Richard Andrew Cattermole)
 *
 *     Permission is hereby granted, free of charge, to any person obtaining a copy
 *     of this software and associated documentation files (the "Software"), to deal
 *     in the Software without restriction, including without limitation the rights
 *     to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *     copies of the Software, and to permit persons to whom the Software is
 *     furnished to do so, subject to the following conditions:
 *
 *     The above copyright notice and this permission notice shall be included in all
 *     copies or substantial portions of the Software.
 *
 *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *     IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *     AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *     LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *     OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *     SOFTWARE.
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

		void set(T v) {
			import std.traits : isPointer, isSomeFunction;
			newValue = currentValue;

			static if (isPointer!T || isSomeFunction!T) {
				if (newValue !is v)
					counter = counterSetTo;
			} else {
				if (newValue != v)
					counter = counterSetTo;
			}
		}

		void mark() {
			if (counter > 1) {
				counter--;
			} else {
				currentValue = newValue;
			}
		}
	}

}