/**
 * A* algorithm implementation.
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
module devisualization.util.algorithms.pathfinding.astar;
import devisualization.util.algorithms.pathfinding.defs;

/**
 * Locates the next node in graph to get to a position
 * Uses A* search algorithm
 * Can use any sortable value type
 *
 * Params:
 *    graph			=	The graph of nodes
 *    start			=	Starting position to go to
 *    goal			=	The end position 
 *    came_from		=	The positions between start and end
 *    cost_so_far	=	Sum of weights (cost) to get to goal from start
 */
void a_star_search(T, U)(GridWithWeights graph, T start, T goal, out T[T] came_from, out U[T] cost_so_far) {
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

///
unittest {
	GridWithWeights!(XY, int) grid = diagram4();
	
	XY[XY] came_from;
	int[XY] cost_so_far;
	a_star_search(grid, XY(1, 4), XY(7, 8), came_from, cost_so_far);
	XY[] path = reconstruct_path(came_from, XY(1, 4), XY(7, 8));
	
	// TODO: asserts
}