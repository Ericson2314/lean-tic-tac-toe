import Std.Data.Array

import TicTacToe.Vector

structure Grid (t : Type) (n : Nat) where
  inner : Vector (Vector t n) n

def Grid.get
    {n : Nat} {t : Type}
    (x y : Fin n)
    (g : Grid t n)
    : t :=
  Vector.get (Vector.get g.inner x) y

instance : Functor (λ t => Grid t n) where
  map f g := {
    inner := Vector.functor.map (Vector.functor.map f) g.inner
  }

def Grid.zip
    { n : Nat}
    {t u v : Type}
    (f : t -> u -> v)
    (g : Grid t n)
    (g : Grid u n)
    : Grid v n
    :=
  sorry
