/**
 * License:
 *              Copyright Devisualization (Richard Andrew Cattermole) 2014 - 2017.
 *     Distributed under the Boost Software License, Version 1.0.
 *        (See accompanying file LICENSE_1_0.txt or copy at
 *              http://www.boost.org/LICENSE_1_0.txt)
 */
module devisualization.util.core.text;
import std.string : indexOf, toUpper, toLower;
import std.traits : isSomeString;

/**
 * Replaces some text in a string.
 * 
 * Params:
 * 		text			=	The old text to replace from
 * 		oldText			=	The text to remove
 * 		newText			=	The text to replace oldText with
 * 		caseSensitive	=	Does 'A' and 'a' the same character? Default: true
 * 		first			=	Stop after the first instance of oldText? Default: false
 * 
 * Returns:
 * 		The text that has been replaced
 */
deprecated("Too memory expensive, requires a rewrite.")
T replace(T)(T text, T oldText, T newText, bool caseSensitive = true, bool first = false) pure if (isSomeString!T) {
	T ret;
	T tempData;
	bool stop;
	foreach(dchar c; text) {
		if (tempData.length > oldText.length && !stop) {
			ret ~= tempData;
			tempData.length = 0;
		}
		if (((oldText[0 .. tempData.length] != tempData && caseSensitive) || (oldText[0 .. tempData.length].toLower() != tempData.toLower() && !caseSensitive)) && !stop) {
			ret ~= tempData;
			tempData.length = 0;
		}
		tempData ~= c;
		if (((tempData == oldText && caseSensitive) || (tempData.toLower() == oldText.toLower() && !caseSensitive)) && !stop) {
			ret ~= newText;
			tempData.length = 0;
			stop = first;
		}
	}
	if (tempData != T.init) {
		ret ~= tempData;	
	}
	return ret;
}

unittest {
	string test = "Hello World!";
	test = test.replace("Hello", "Hi");
	assert(test == "Hi World!");
	
	assert(replace("Hello World!", "o", "a") == "Hella Warld!");
	assert(replace("Hello World!", "!", "#") == "Hello World#");
}

/**
 * Split a string by a delimater
 * 
 * Params:
 * 		text		=	The text to split from
 * 		delimater	=	The text to split by
 * 
 * Returns:
 * 		An array of text that has been split
 */
deprecated("Use std.algorithm.iteration : splitter instead.")
pure T[] split(T)(T text, T delimater) if (isSomeString!T) {
	T[] ret;
	ptrdiff_t i;
	while((i = text.indexOf(delimater)) >= 0) {
		ret ~= text[0 .. i];
		text = text[i + delimater.length .. $];
	}
	if (text.length > 0) {
		ret ~= text;	
	}
	return ret;
}

unittest {
	string test = "abcd|efgh|ijkl";
	assert(test.split("|") == ["abcd", "efgh", "ijkl"]);
	string test2 = "abcd||efgh||ijkl";
	assert(test2.split("||") == ["abcd", "efgh", "ijkl"]);
}

/**
 * Multiplies a string by itself and concactenates it onto the resulting string
 *
 * Similar to how Python's string multiplication works.
 *
 * Params:
 * 		text	=	The text to multiply
 * 		count	=	How many times to multiply it
 *
 * Returns:
 * 		The multiplied string
 */
T multiply(T)(T text, size_t count) pure @safe nothrow if (isSomeString!T) {
	alias U = typeof(cast()T.init[0]);
	U[] ret;
	ret.length = text.length * count;

	size_t j;
	foreach(i; 0 .. count) {
		ret[j .. j + text.length] = text[];
		j += text.length;
	}

	return ret;
}

unittest {
	assert(" ".multiply(3) == "   ");
	assert("hello ".multiply(2) == "hello hello ");
	assert("boo".multiply(1) == "boo");
	assert("huh".multiply(0) == "");
}

/**
 * Gets a string which has been indented to x spaces.
 * Uses four spaces, not tabs.
 *
 * Params:
 * 		count	=	How many times to indent it
 *
 * Returns:
 * 		The indented string
 */
string getSpaceIndent(size_t count) pure @safe nothrow {
	return "    ".multiply(count);
}