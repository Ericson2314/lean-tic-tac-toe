-- This module serves as the root of the `TicTacToe` library.
-- Import modules here that should be built as part of the library.
import TicTacToe.Basic
import TicTacToe.Vector
import TicTacToe.Grid

inductive Player where
  | x : Player
  | o : Player
  deriving Repr, DecidableEq

inductive CellState where
  | empty : CellState
  | filled : Player -> CellState
  deriving Repr, DecidableEq

structure Board (n : Nat) where
  grid : Grid CellState n
  deriving Repr

def Board.init {n : Nat} : Board n := {
  grid := Grid.mkGrid CellState.empty
}

#eval (Board.init : Board 2)

def Board.move
  (b : Board n) (turn : Player) (x y : Fin n) : Option (Board n) :=
  do
    let grid <- b.grid.modifyM x y (λ cell =>
          match cell with
            | CellState.empty => pure (CellState.filled turn)
            | _ => Option.none)
    pure {grid}

#eval (Board.init : Board 2).move Player.x 1 1

def completeSeries (v : Vector CellState n) : Option Player :=
  if
    v.array.all (λ c => c == CellState.filled Player.x) then some Player.x
  else if
    v.array.all (λ c => c == CellState.filled Player.o) then some Player.o
  else
    none

def diagonalOne (b : Board n) : Vector CellState n :=
  Vector.ofFn <| λ x => b.grid.get x x

def diagonalTwo (b : Board n) : Vector CellState n :=
  Vector.ofFn <| λ x => b.grid.get
    x
    {
      val := n - 1 - x
      isLt := sorry -- TODO should be easy
    }

def gameDone (b : Board n) : Option Player :=
  (((b.grid.inner.array.findSome? completeSeries).orElse
  (λ () => b.grid.transpose.inner.array.findSome? completeSeries)).orElse <|
  (λ () => completeSeries (diagonalOne b))).orElse
  (λ () => completeSeries (diagonalTwo b))

def BoardTransition {n : Nat} (turn : Player) (prev next : Board n) : Prop :=
  ∃ (x y : Fin n),
    Grid.get prev.grid x y = CellState.empty ∧
    Grid.get next.grid x y = CellState.filled turn ∧
    ∀ (i j : Fin n),
      (i ≠ x ∨ j ≠ y) → Grid.get prev.grid i j = next.grid.get i j

theorem movesAreValid
  {n : Nat}
  (prev : Board n) (turn : Player) (x y : Fin n)
  {next : Board n}
  {eval : Board.move prev turn x y = Option.some next}
  : BoardTransition turn prev next
  := sorry
