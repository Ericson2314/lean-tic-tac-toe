import Std.Data.Array

structure Vector (α : Type) (n : Nat) where
  array : Array α
  sz : n = Array.size array
  deriving Repr

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

def foo
  {α : Type u}
  {m : Type u -> Type u_2}
  [Monad m]
  [LawfulMonad m]
  (a : Array α)
  (n : Nat)
  (f : α -> m α)
  : {action: m (Array α) // SatisfiesM (fun (x : Array α) => x.size = a.size) action}
  := {
      val := a.modifyM n f
      property := a.size_modifyM n f
    }

-- Not sure how to do this,
-- see https://leanprover.zulipchat.com/#narrow/stream/113489-new-members/topic/.E2.9C.94.20Proofs.20inside.20monads/near/466762282
def internalizePostCondition
  {m : Type u -> Type u_2}
  [Monad m]
  [LawfulMonad m]
  (action : {action: m α // SatisfiesM p action})
  : m {value: α // p value}
  := sorry

def Vector.modifyM
    {n : Nat}
    {m : Type -> Type}
    [Monad m]
    [LawfulMonad m]
    (v : Vector α n)
    (i : Fin n)
    (f : α → m α)
    : m (Vector α n) :=
  do
    let array ← internalizePostCondition (foo v.array i f)
    pure {
      array := array.val
      sz := by
        rw [array.property]
        exact v.sz
    }
