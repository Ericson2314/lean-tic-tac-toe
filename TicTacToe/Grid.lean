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


def Grid.zipWith
    {n : Nat} {t u : Type}
    (f : t -> u -> v)
    (a : Grid t n)
    (b : Grid u n)
    : Grid v n :=
  {
    inner := Vector.zipWith (Vector.zipWith f) a.inner b.inner
  }
