# Peg Solitare Decision Tree Generator
This generates the entire decision tree for the triangular peg solitare game. The algorithm is set up to run with any size or shape board with any starting configuation.

The final tree for the triangular game contains 1,293,179 nodes and finishes in roughly 70 seconds.

This algorithm is not intended to find a solution to the puzzle quickily. The use of this was to generate the entire move tree and use that to study all of the winning and losing moves that could be made to attempt to come up with a set of deterministic steps to win the game from any point. This would hopefully allow for an algorithm to be created that could solve the puzzle in an extremely short amount of time.
