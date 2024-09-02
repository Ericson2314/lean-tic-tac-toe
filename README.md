# [Tic-tac-toe](https://en.wikipedia.org/wiki/Tic-tac-toe) in [Lean 4](https://lean-lang.org/)

Tic-tac-toe is a game of a sqare matrix over 3 states.
The "Fibonacci" equivalent for dependent types is fixed-length arrays, and this little thing is very useful for squares:
arrays of arrays where all the interior arrays must be the same length.

All the pure code is in the `TicTacToe` library.
First we develop `Vector`, then `Grid`, then `Board`.
The nasty-in-comparison standard stream rudimentary Input/Output is in `Main`.

Nothing interesting is prooved, but the code is failure-free:
it is not guaranteed to terminate (e.g. if one keeps on typing invalid numbers at the prompts),
but it will never error.
There are no implicit failures.
