-- This module serves as the root of the `TicTacToe` library.
-- Import modules here that should be built as part of the library.
import TicTacToe.Basic
import TicTacToe.Vector
import TicTacToe.Grid

inductive Player where
  | X : Player
  | O : Player

inductive CellState where
  | Empty : CellState
  | Filled : Player -> CellState

inductive CellTransition : CellState -> CellState -> Type where
  | Stay : CellTransition x x
  | Fill : CellTransition CellState.Empty x

def Board n := Grid CellState n
