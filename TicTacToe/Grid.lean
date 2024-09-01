import Std.Data.Array

import TicTacToe.Vector

structure Grid (t : Type) (n : Nat) where
  inner : Vector (Vector t n) n
  deriving Repr

def Grid.get
    {n : Nat} {t : Type}
    (g : Grid t n)
    (x y : Fin n)
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

def Grid.mkGrid {n : Nat} (val : t) : Grid t n := {
    inner := Vector.mkVector (Vector.mkVector val)
  }

def Grid.modifyM
    {n : Nat}
    {m : Type -> Type}
    [Monad m]
    [LawfulMonad m]
    (g : Grid t n)
    (x : Fin n)
    (y : Fin n)
    (f : t → m t)
    : m (Grid t n) :=
  do
    let inner <- Vector.modifyM g.inner x
          (λ column => Vector.modifyM column y f)
    pure {
      inner
    }

def Grid.transpose
    {n : Nat} {t : Type}
    (g : Grid t n)
    : Grid t n :=
  {
    inner := Vector.ofFn <| λ y =>
      Vector.functor.map
        (λ column => Vector.get column y)
        g.inner
  }
