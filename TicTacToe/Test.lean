import TicTacToe

#eval (Board.init : Board 2)

#eval (Board.init : Board 2).move Player.x 1 1 =
  some {
    grid := {
      inner := {
        array := #[
          {
            array := #[CellState.empty, CellState.empty]
            sz := by simp
          },
          {
            array := #[CellState.empty, CellState.filled (Player.x)]
            sz := by simp
          }
        ],
        sz := by simp
      }
    }
  }

#eval (Board.init : Board 3).move Player.o 0 1 =
  some {
    grid := {
      inner := {
        array := #[
          {
            array := #[CellState.empty, CellState.filled (Player.o), CellState.empty]
            sz := by simp
          },
          {
            array := #[CellState.empty, CellState.empty, CellState.empty]
            sz := by simp
          },
          {
            array := #[CellState.empty, CellState.empty, CellState.empty]
            sz := by simp
          }
        ],
        sz := by simp
      }
    }
  }

#eval none = @gameDone 3
  {
    grid := {
      inner := {
        array := #[
          {
            array := #[CellState.empty, CellState.filled (Player.o), CellState.empty]
            sz := by simp
          },
          {
            array := #[CellState.empty, CellState.empty, CellState.empty]
            sz := by simp
          },
          {
            array := #[CellState.empty, CellState.empty, CellState.empty]
            sz := by simp
          }
        ],
        sz := by simp
      }
    }
  }

#eval
  let o := CellState.filled (Player.o)
  some (Player.o) = @gameDone 3
  {
    grid := {
      inner := {
        array := #[
          {
            array := #[o, o, o]
            sz := by simp
          },
          {
            array := #[CellState.empty, CellState.empty, CellState.empty]
            sz := by simp
          },
          {
            array := #[CellState.empty, CellState.empty, CellState.empty]
            sz := by simp
          }
        ],
        sz := by simp
      }
    }
  }

#eval
  let o := CellState.filled (Player.o)
  some (Player.o) = @gameDone 3
  {
    grid := {
      inner := {
        array := #[
          {
            array := #[o, CellState.empty, CellState.empty]
            sz := by simp
          },
          {
            array := #[o, CellState.empty, CellState.empty]
            sz := by simp
          },
          {
            array := #[o, CellState.empty, CellState.empty]
            sz := by simp
          }
        ],
        sz := by simp
      }
    }
  }

#eval
  let o := CellState.filled (Player.o)
  some (Player.o) = @gameDone 3
  {
    grid := {
      inner := {
        array := #[
          {
            array := #[o, CellState.empty, CellState.empty]
            sz := by simp
          },
          {
            array := #[CellState.empty, o, CellState.empty]
            sz := by simp
          },
          {
            array := #[CellState.empty, CellState.empty, o]
            sz := by simp
          }
        ],
        sz := by simp
      }
    }
  }

#eval
  let o := CellState.filled (Player.o)
  some (Player.o) = @gameDone 3
  {
    grid := {
      inner := {
        array := #[
          {
            array := #[CellState.empty, CellState.empty, o]
            sz := by simp
          }
          {
            array := #[CellState.empty, o, CellState.empty]
            sz := by simp
          },
          {
            array := #[o, CellState.empty, CellState.empty]
            sz := by simp
          },
        ],
        sz := by simp
      }
    }
  }
