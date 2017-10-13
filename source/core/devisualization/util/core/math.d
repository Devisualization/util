/**
 * License:
 *              Copyright Devisualization (Richard Andrew Cattermole) 2014 - 2017.
 *     Distributed under the Boost Software License, Version 1.0.
 *        (See accompanying file LICENSE_1_0.txt or copy at
 *              http://www.boost.org/LICENSE_1_0.txt)
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