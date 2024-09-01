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
    rw [←sz]
    exact i.isLt)

instance Vector.functor : Functor (λ t => Vector t n) where
  map f v := {
    array := Array.map f v.array
    sz := by
      rw [Array.size_map f v.array]
      exact v.sz
  }
