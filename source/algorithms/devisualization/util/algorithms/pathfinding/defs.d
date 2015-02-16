/**
 * Utility code for path finding
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
 *
 * See_Also:
 *		http://www.redblobgames.com/pathfinding/a-star/implementation.html
 */
module devisualization.util.algorithms.pathfinding.defs;

version(unittest) {
	struct XY {
		int x;
		int y;
	}

	T from_id_width(T)(T v, T width) pure { return XY(id % width, id / width); }
	enum XY[] DIAGRAM1_WALLS = [21,22,51,52,81,82,93,94,111,112,123,124,133,134,141,142,153,154,163,164,171,172,173,174,175,183,184,193,194,201,202,203,204,205,213,214,223,224,243,244,253,254,273,274,283,284,303,304,313,314,333,334,343,344,373,374,403,404,433,434].from_id_width;

	GridWithWeights!(XY, int) diagram4() {
		GridWithWeights!(XY, int) ret = GridWithWeights(10, 10);
		ret.walls = [XY(1, 7), XY(1, 8), XY(2, 7), XY(2, 8), XY(3, 7), XY(3, 8)];
		ret.weights = [(3, 4), (3, 5), (4, 1), (4, 2),
					   (4, 3), (4, 4), (4, 5), (4, 6), 
					   (4, 7), (4, 8), (5, 1), (5, 2),
					   (5, 3), (5, 4), (5, 5), (5, 6), 
					   (5, 7), (5, 8), (6, 2), (6, 3), 
					   (6, 4), (6, 5), (6, 6), (6, 7), 
					   (7, 3), (7, 4), (7, 5)];
		return ret;
	}
}

/**
 * Does the type have:
 * - x
 * - y
 * - x and y being both the same type
 * - Ability to be initiated like a struct (think opCall for classes)
 *
 * Params:
 *     T	=	The type
 *
 * Returns:
 *     If the value is compliant
 */
bool hasXYPoints(T)() {
	return __traits(hasMember, T, "x") && __traits(hasMember, T, "y") &&
           is(typeof(T.x) == typeof(T.y)) &&
		   __traits(compiles, { T v = T(typeof(T.x).init, typeof(T.y).init); });
}

/**
 * The distance between two points
 * Type of parameters must abide by hasXYPoints
 *
 * Params:
 *     a	=	The first position
 *     b	=	The second position
 *
 * Returns:
 *     The distance
 *
 * See_Also:
 *     hasXYPoints
 */
T heuristic(T, U = typeof(T.x))(T a, T b) if (hasXYPoints!T) {
	import std.math : abs;
	return cast(U)(abs(a.x - b.x) + abs(a.y - b.y));
}

/**
 * Turns the output from a search algorithm into a set path
 *
 * Params:
 *    came_from		=	The positions between start and end
 *    start			=	Starting position to go to
 *    goal			=	The end position
 *
 * Returns:
 *     A path from a position to another
 *
 * See_Also:
 *     dijkstra_search, a_star_search, breadth_first_search
 */
T[] reconstruct_path(T)(T[] came_from, T start, T goal) {
	T current = goal;
	T[] path = [current];
	
	while (current != start) {
		current = came_from[current];
		path ~= current;
	}
	
	return path;
}

/**
 * A simple graph structure
 */
struct Graph(T=string) {
	private {
		T[][T] edges_;
	}
	
	@property {
		/**
		 * Get the edges this graph has
		 *
		 * Returns:
		 *     The edges of the graph
		 */
		T[][T] edges() { return edges_; }
		
		/**
		 * Set the edges this graph has
		 *
		 * Params:
		 *     value	=	The new edges of the graph
		 */
		void edges(T[][T] value) { edges_ = value; }
	}
	
	/**
	 * Get a set edge, neighbors
	 *
	 * Params:
	 *     The id of the edge
	 *
	 * Returns:
	 *     The neighbor edges or null if id doesn't exist
     */
	T[] neighbors(T id) { return edges_.get(id, null); }
}

/**
 * A 2d grid that is rectangle in nature
 *
 * Params:
 *    T	=	A point type with x and y fields
 *    U	=	The type of x and y
 */
struct SquareGrid(T, U = typeof(T.x)) if (hasXYPoints!T) {
	Graph this_;
	alias this_ this;
	
	private {
		U width_;
		U height_;
		
		T[] walls_;
	}
	
	/**
	 * Creates the grid given the size
	 *
	 * Params:
	 *     width	=	Width of the grid
	 *     height	=	Height of the grid
	 */
	this(U width, U height) {
		width_ = width;
		height_ = height;
	}
	
	/**
	 * Is a given position within the grid
	 *
	 * Params:
	 *     id	=	The position
	 *
	 * Returns:
	 *     If the position is within the grid
     */
	bool in_bounds(T id) {
		return 0 <= id.x && id.x < width_ &&
			   0 <= id.y && id.y < height_;
	}
	
	/**
	 * Is a given position blocked by a wall
	 *
	 * Params:
	 *     id	=	The position
	 *
	 * Returns:
	 *     If the position is blocked by a wall
     */
	bool passable(T id) {
		import std.algorithm : canFind;
		return walls_.canFind(id);
	}
	
	/**
	 * Get a set edge, neighbors
	 *
	 * Params:
	 *     id	=	The id of the edge
	 *
	 * Returns:
	 *     The neighbor edges or null if id doesn't exist
     */
	string[] neighbors(T id) {
		import std.algorithm : reverse, filter, moveAll;

		T[] results = [T(id.x + 1, id.y), T(id.x, id.y - 1), T(id.x - 1, id.y), T(id.x, id.y + y)];
		if ((id.x + id.y) % 2 == 0)
			results = results.reverse;
		
		filter!`in_bounds(a) && passable(a)`(results).moveAll(results);
		
		return results;
	}
}

/**
 * A grid that has weighting per node
 *
 * Params:
 *    T	=	A point type with x and y fields
 *    U	=	The type of x and y
 */
struct GridWithWeights(T, U = ubyte, V = typeof(T.x)) {
	SquareGrid!(T, V) this_;
	alias this_ this;
	
	private {
		U[T] weights_;
	}
	
	/**
	 * Gets the weighting for an item
	 *
	 * Params:
	 *     a		=	Previous position
	 *     b		=	Current position
	 *     default_	=	Default value to return. Default: 1
	 */
	U cost(T a, T b, U default_ = 1) {
		return weights_.get(b, default_);
	}
}

/**
 * A simple wrap around a DList
 *
 * See_Also:
 *    std.algorithm.DList
 */
struct Queue(T) {
	DList!T this_;
	alias this_ this;
	
	/**
	 * Adds an item to the queue
	 *
	 * Params:
	 *     x	=	The value to add
	 */
	void put(T x) { this_ ~= x; }
	
	/**
	 * Gets the front item (FIFO) of the queue
	 *
	 * Returns:
	 *     The first item in queue
	 */
	T get() {
		T ret = this_.opSlice().front;
		this_.opSlice().popFront;
		return ret;
	}
}

/**
 * A wrapper around BinaryHeap
 * Sorts a set of items based upon a priority
 *
 * Params:
 *    T	=	The queue item type
 *    U	=	The priority type
 *
 * See_Also:
 *     std.collections.binaryheap.BinaryHeap
 */
struct PriorityQueue(T, U=ubyte) {
	struct PriorityQueueItem {
		T item;
		U priority;
	}
	
	BinaryHeap!(PriorityQueueItem, `a.priority < b.priority`) elements;
	alias elements this;
	
	/**
	 * Adds an item to the queue
	 *
	 * Params:
	 *     item		=	The value to add
	 *     priority	=	The priority of the item
	 */
	void put(T item, U priority) { elements ~= PriorityQueueItem(item, priority); }
	
	/**
	 * Gets the front item (FIFO) of the queue
	 *
	 * Returns:
	 *     The first item in queue sorted based upon the priority
	 */
	U get() {
		T ret = this_.opSlice().front;
		this_.opSlice().popFront;
		return ret;
	}
}