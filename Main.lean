import TicTacToe
import TicTacToe.Test

def playerToChar (p : Player) : Char := match p with
  | Player.x => 'X'
  | Player.o => 'O'

def printRow (v : Vector CellState n) : IO Unit := do
  for c in v.array do
    IO.print $ match c with
      | CellState.empty => '☐'
      | CellState.filled p =>  playerToChar p
  IO.println ""

def printBoard (b : Board n) : IO Unit := do
  for v in b.grid.inner.array do
    printRow v

partial def getNumber (decPred : Nat -> Sum String α) : IO α :=
  let rec go := do
    let stdin ← IO.getStdin
    let valS ← String.trim <$> stdin.getLine
    match valS.toNat? with
      | none => do
        IO.println "Invalid natural number, please try again"
        go
      | some val => match decPred val with
         | Sum.inr ret => pure ret
         | Sum.inl msg => do
           IO.println msg
           go
  go

partial def getCoord {n: Nat} : IO (Fin n) := getNumber <|
  λ val => match (inferInstance : Decidable (val < n)) with
    | Decidable.isTrue isLt => Sum.inr ({ val, isLt } : Fin n)
    | Decidable.isFalse _ => Sum.inl "coordinate too large, please try again"

partial def getMove {n} (b : Board n) (p : Player) : IO (Board n) :=
  let rec go := do
    IO.println
      s!"Player {playerToChar p} please enter x then y coordinates"
    let x <- getCoord
    let y <- getCoord
    match b.move p x y with
      | some b' => pure b'
      | none => do
        IO.println "Invalid move, please try again"
        go
  go

partial def main : IO Unit := do
  IO.println "Tic-Tac-Toe without bounds checks*!"
  IO.println ""
  IO.println "*In theory"
  IO.println ""

  IO.println "Please enter the board size"

  let nsub <- getNumber <| λ n => match n with
    | 0 => Sum.inl "board size must be at least 1, please try again"
    | Nat.succ nsub => Sum.inr nsub

  let b : Board (Nat.succ nsub) := Board.init

  printBoard b

  let rec go {n} (b : Board (Nat.succ n)) (p : Player) : IO Unit := do
    let b' <- getMove b p

    printBoard b'

    match gameDone b' with
      | none => do
        go b' <| match p with
          | Player.x => Player.o
          | Player.o => Player.x
      | some p => do
        IO.println ""
        IO.println s!"Congrats {playerToChar p}!"

  go b Player.x
