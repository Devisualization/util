/**
 * Bellman-Ford path finding algorithm
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
 *		http://en.wikipedia.org/wiki/Bellman%E2%80%93Ford_algorithm
 */
module devisualization.util.algorithms.pathfinding.bellmanford;
import devisualization.util.algorithms.pathfinding.defs;

/**
 * Performs a Bellman-Ford search on a graph
 *
 * Params:
 *     graph		=	The graph
 *     source		=	The starting position
 *     distance		=	Output: Distance between node and starting position
 *     predecessor	=	Output: A node's previous node
 */
void bellmanFord_search(T, U)(GridWithWeights graph, T source, out U[T] distance, out T[T] predecessor) {
   // This implementation takes in a graph, represented as
   // lists of vertices and edges, and fills two arrays
   // (distance and predecessor) with shortest-path
   // (less cost/distance/metric) information

   // Step 1: initialize graph
	foreach(k, v; graph.edges) {
		if (k == source)
			distance[k] = T.init;
		else
			static if (__traits(compiles, {T v = T.nan;}))
				distance[k] = T.nan;
			else
				distance[k] = T.max;
       
		predecessor[k] = null;
   }

    // Step 2: relax edges repeatedly
    foreach(k, v; graph.edges) {
		foreach(v2; v) {
			auto w = graph.cost(k, v2);
			
			if (distance[u] + w < distance[v]) {
				distance[v] = distance[u] + w;
				predecessor[v] = u;
			}
		}
    }
			   
   // Step 3: check for negative-weight cycles
   foreach(k, v; graph.edges) {
		foreach(v2; v) {
			auto w = graph.cost(k, v2);
			
			if (distance[u] + w < distance[v]) {
				throw new Exception("Graph contains a negative-weight cycle");
			}
		}
   }
}