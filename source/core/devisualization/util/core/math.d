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
module devisualization.util.core.math;

private {
	static const(ulong[]) factorialLookupTable = [
		1,
		1,
		2,
		6,
		24,
		120,
		720,
		5040,
		40320,
		362880,
		3628800,
		39916800,
		479001600,
		6227020800,
		87178291200,
		1307674368000,
		20922789888000,
		355687428096000,
		6402373705728000,
		121645100408832000,
		2432902008176640000
	];
}

/**
 * Returns a cached factorial value.
 * 
 * Params:
 * 		n	=	How many times to recurse
 * 
 * Returns:
 * 		A cached value of factorial between 0 and 32 recursion.
 */
double factorial(size_t n) @safe nothrow
in {
	assert(n >= 0);
	assert(n < factorialLookupTable.length);
} body {
	return factorialLookupTable[n];
}