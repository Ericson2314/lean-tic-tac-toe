-- This module serves as the root of the `TicTacToe` library.
-- Import modules here that should be built as part of the library.
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
  deriving Repr, DecidableEq

def Board.init {n : Nat} : Board n := {
  grid := Grid.mkGrid CellState.empty
}

def Board.move
  (b : Board n) (turn : Player) (x y : Fin n) : Option (Board n) :=
  do
    let grid <- b.grid.modifyM x y (λ cell =>
          match cell with
            | CellState.empty => pure (CellState.filled turn)
            | _ => Option.none)
    pure {grid}

def completeSeries (v : Vector CellState (Nat.succ n)) : Option Player :=
  let first := v.get 0
  match first with
    | CellState.empty => none
    | CellState.filled player =>
        if v.array.all (λ c => c == CellState.filled player)
        then some Player.x
        else none

def diagonalOne (b : Board n) : Vector CellState n :=
  Vector.ofFn <| λ x => b.grid.get x x

def invertFin (x : Fin n) : Fin n :=
  match n with
    | 0 => Fin.elim0 x
    | (Nat.succ m) => {
      val := m - x
      isLt := Nat.sub_lt_succ m ↑x
    }

def diagonalTwo (b : Board n) : Vector CellState n :=
  Vector.ofFn <| λ x => b.grid.get x (invertFin x)

def gameDone (b : Board (Nat.succ n)) : Option Player :=
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
