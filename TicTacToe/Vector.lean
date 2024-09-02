import Std.Data.Array

structure Vector (α : Type) (n : Nat) where
  array : Array α
  sz : n = Array.size array
  deriving Repr, DecidableEq

def Vector.get
    {n : Nat} {α : Type}
    (g : Vector α n)
    (i : Fin n)
    : α :=
  g.array[i]'(by
    rw [← sz]
    exact i.isLt)

instance Vector.functor : Functor (λ α => Vector α n) where
  map f v := {
    array := Array.map f v.array
    sz := by
      rw [Array.size_map f v.array]
      exact v.sz
  }

def Vector.zipWith
    {n : Nat} {α u : Type}
    (f : α -> u -> v)
    (a : Vector α n)
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

def Vector.mkVector {n : Nat} (val : α) : Vector α n := {
    array := Array.mkArray n val
    sz := Eq.symm (Array.size_mkArray n val)
  }

def Vector.ofFn {n : Nat} (f : Fin n → α) : Vector α n
  := {
    array := Array.ofFn f
    sz := Eq.symm (Array.size_ofFn f)
  }

def Vector.modifyM
    {n : Nat}
    {m : Type -> Type}
    [Monad m]
    (v : Vector α n)
    (i : Fin n)
    (f : α → m α)
    : m (Vector α n) :=
  do
    let x := v.get i
    let x' <- f x
    let i' := by rw [← v.sz]; exact i
    pure {
      array := v.array.set i' x'
      sz := by
        rw [v.array.size_set i' x']
        exact v.sz
    }
