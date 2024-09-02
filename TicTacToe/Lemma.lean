import TicTacToe

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
  := ⟨x, ⟨y, sorry⟩⟩
