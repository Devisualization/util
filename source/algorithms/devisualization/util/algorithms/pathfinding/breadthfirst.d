/**
 * Breadthfirst path finding algorithm
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
module devisualization.util.algorithms.pathfinding.breadthfirst;
import devisualization.util.algorithms.pathfinding.defs;
deprecated("Killing"):

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
				came_from[next] = current;
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
				came_from[next] = current;
			}
		}
	}
	
	return came_from;
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
 * Locates the next node in graph to get to a position
 *
 * Params:
 *    graph		=	The graph of nodes
 *    start		=	Starting position to go to
 *    goal		=	The end position 
 *    came_from	=	Output: An AA mapping a position to another to get to a point
 *    distance	=	Output: Distance of a node to the end point
 *
 * See_Also:
 *     http://www.redblobgames.com/pathfinding/tower-defense/
 */
void breadth_first_search(T, U)(Graph graph, T start, T goal, out T[T] came_from, out U[T] distance) {
	Queue!T frontier;
	frontier.put(start);
	distance[start] = 0;
	
	while(!frontier.empty) {
		T current = frontier.get();
		if (current == goal)
			break;
		
		foreach(next; graph.neighbors(current)) {
			if (next !in came_from) {
				frontier.put(next);
				came_from[next] = current;
				distance[next] = 1 + distance[current];
			}
		}
	}
}