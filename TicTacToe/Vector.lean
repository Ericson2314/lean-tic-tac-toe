import Std.Data.Array

structure Vector (t : Type) (n : Nat) where
  array : Array t
  sz : n = Array.size array

def Vector.get
    {n : Nat} {t : Type}
    (g : Vector t n)
    (i : Fin n)
    : t :=
  g.array[i]'(by
    rw [← sz]
    exact i.isLt)

instance Vector.functor : Functor (λ t => Vector t n) where
  map f v := {
    array := Array.map f v.array
    sz := by
      rw [Array.size_map f v.array]
      exact v.sz
  }

def Vector.zipWith
    {n : Nat} {t u : Type}
    (f : t -> u -> v)
    (a : Vector t n)
    (b : Vector u n)
    : Vector v n :=
  {
    array := Array.zipWith a.array b.array f
    sz := by
      rw [Array.size_zipWith a.array b.array f]
      rw [← a.sz, ← b.sz]
      apply Eq.symm
      exact Nat.min_self n
  }
