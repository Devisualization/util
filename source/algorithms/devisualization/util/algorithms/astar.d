/**
 * A* alogirhtm implementation.
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
module devisualization.util.algorithms.astar;
import std.container.dlist : DList;
import std.container.binaryheap : BinaryHeap;

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
 * Locates the next node in graph to get to a position
 *
 * Params:
 *    graph	=	The graph of nodes
 *    start	=	Starting/End position to go to
 *
 * Returns:
 *     An AA mapping a position to another to get to a point
 */
T[T] breadth_first_search(T)(Graph graph, T start) {
	Queue!T frontier;
	frontier.put(start);
	T[T] came_from;
	
	while(!frontier.empty) {
		T current = frontier.get();
		foreach(next; graph.neighbors(current)) {
			if (next !in came_from) {
				frontier.put(next);
				visited[next] = current;
			}
		}
	}
	
	return came_from;
}

/**
 * Locates the next node in graph to get to a position
 *
 * Params:
 *    graph	=	The graph of nodes
 *    start	=	Starting position to go to
 *    goal	=	The end position 
 *
 * Returns:
 *     An AA mapping a position to another to get to a point
 */
T[T] breadth_first_search(T)(Graph graph, T start, T goal) {
	Queue!T frontier;
	frontier.put(start);
	T[T] came_from;
	
	while(!frontier.empty) {
		T current = frontier.get();
		if (current == goal)
			break;
		
		foreach(next; graph.neighbors(current)) {
			if (next !in came_from) {
				frontier.put(next);
				visited[next] = current;
			}
		}
	}
	
	return came_from;
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

unittest {
	Graph!string example_graph;
	
	example_graph.edges = [
		"A": ["B"],
		"B": ["A", "C", "D"],
		"C": ["A"],
		"D": ["E", "A"],
		"E": ["B"]
	];
	
	breadth_first_search(example_graph, "A");
	
	// TODO: asserts
}

unittest {
	SquareGrid!XY grid = SquareGrid!XY(30, 15);
	grid.walls = DIAGRAM1_WALLS;
	
	XY[] parents = breadth_first_search(grid, XY(8, 7));
	
	//TODO: asserts
}

unittest {
	SquareGrid!XY grid = SquareGrid!XY(30, 15);
	grid.walls = DIAGRAM1_WALLS;
	
	XY[] parents = breadth_first_search(grid, XY(8, 7), XY(17, 2));
	
	//TODO: asserts
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

/**
 * Locates the next node in graph to get to a position
 * Uses Dijkstra search algorithm
 *
 * Params:
 *    graph			=	The graph of nodes
 *    start			=	Starting position to go to
 *    goal			=	The end position 
 *    came_from		=	The positions between start and end
 *    cost_so_far	=	Sum of weights (cost) to get to goal from start
 */
void dijkstra_search(T, U)(GridWithWeights graph, T start, T goal, out T[T] came_from, out U[T] cost_so_far) {
	PriorityQueue!(T, U) frontier;
	frontier.put(start, 0);
	
	cost_so_far[start] = 0;
	
	while(!frontier.empty) {
		T current = frontier.get();
		if (current == goal)
			break;
		
		foreach(next; graph.neighbors(current)) {
			U new_cost = cost_so_far[current] + graph.cost(current, next);
		
			if (next !in cost_so_far || new_cost < cost_so_far[next]) {
				cost_so_far[next] = new_cost;
				priority = new_cost;
				
				frontier.put(next, priority);
				visited[next] = current;
			}
		}
	}
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

unittest {
	GridWithWeights!(XY, int) grid = diagram4();
	
	XY[XY] came_from;
	int[XY] cost_so_far;
	dijkstra_search(grid, XY(1, 4), XY(7, 8), came_from, cost_so_far);
	XY[] path = reconstruct_path(came_from, XY(1, 4), XY(7, 8));
	
	// TODO: asserts
}

/**
 * Locates the next node in graph to get to a position
 * Uses A* search algorithm
 *
 * Params:
 *    graph			=	The graph of nodes
 *    start			=	Starting position to go to
 *    goal			=	The end position 
 *    came_from		=	The positions between start and end
 *    cost_so_far	=	Sum of weights (cost) to get to goal from start
 */
void a_star_search(T)(GridWithWeights graph, T start, T goal, out T[T] came_from, out U[T] cost_so_far) {
	PriorityQueue!(T, U) frontier;
	frontier.put(start, 0);
	
	cost_so_far[start] = 0;
	
	while(!frontier.empty) {
		T current = frontier.get();
		if (current == goal)
			break;
		
		foreach(next; graph.neighbors(current)) {
			U new_cost = cost_so_far[current] + graph.cost(current, next);
		
			if (next !in cost_so_far || new_cost < cost_so_far[next]) {
				cost_so_far[next] = new_cost;
				priority = new_cost + heuristic(goal, next);
				
				frontier.put(next, priority);
				visited[next] = current;
			}
		}
	}
}

unittest {
	GridWithWeights!(XY, int) grid = diagram4();
	
	XY[XY] came_from;
	int[XY] cost_so_far;
	a_star_search(grid, XY(1, 4), XY(7, 8), came_from, cost_so_far);
	XY[] path = reconstruct_path(came_from, XY(1, 4), XY(7, 8));
	
	// TODO: asserts
}

private {
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
	
	bool hasXYPoints(T)() {
		return __traits(hasMember, T, "x") && __traits(hasMember, T, "y") && __traits(compiles, { T v = T(typeof(T.x).init, typeof(T.y).init); });
	}
	
	T heuristic(T, U = typeof(T.x))(T a, T b) if (hasXYPoints!T) {
		import std.math : abs;
		return cast(U)(abs(a.x - b.x) + abs(a.y - b.y));
	}
}