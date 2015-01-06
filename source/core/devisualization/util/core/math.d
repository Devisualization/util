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
	const double[33] factorialLookupTable = [
		1.0,
		1.0,
		2.0,
		6.0,
		24.0,
		120.0,
		720.0,
		5040.0,
		40320.0,
		362880.0,
		3628800.0,
		39916800.0,
		479001600.0,
		6227020800.0,
		87178291200.0,
		1307674368000.0,
		20922789888000.0,
		355687428096000.0,
		6402373705728000.0,
		121645100408832000.0,
		2432902008176640000.0,
		51090942171709440000.0,
		1124000727777607680000.0,
		25852016738884976640000.0,
		620448401733239439360000.0,
		15511210043330985984000000.0,
		403291461126605635584000000.0,
		10888869450418352160768000000.0,
		304888344611713860501504000000.0,
		8841761993739701954543616000000.0,
		265252859812191058636308480000000.0,
		8222838654177922817725562880000000.0,
		263130836933693530167218012160000000.0
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
double factorial(size_t n)
in {
	assert(n >= 0);
	assert(n <= 32);
} body {
	return factorialLookupTable[n];
}