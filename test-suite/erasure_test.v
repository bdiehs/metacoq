From MetaCoq.Template Require Import Loader.
From MetaCoq.Erasure Require Import Loader.
Local Open Scope string_scope.

MetaCoq Erase nat.
(*
Environment is well-formed and Ind(Coq.Init.Datatypes.nat,0,[]) has type: ⧆
*)

MetaCoq Erase I.
MetaCoq Erase true.
(*
Environment is well-formed and Construct(Coq.Init.Logic.True,0,0,[]) erases to:
⧆
Environment is well-formed and Construct(Coq.Init.Datatypes.bool,0,0,[]) erases to:
Construct(Coq.Init.Datatypes.bool,0,0)
*)

MetaCoq Erase (exist _ 0 (eq_refl 0) : {x : nat | x = 0}).
(*
Environment is well-formed and exist nat (fun x : nat => eq nat x O) O (eq_refl nat O):sig nat (fun x : nat => eq nat x O) erases to:
(fun f => f) (exist ∎ ∎ O ∎)
*)
MetaCoq Erase (3 + 1).

Universe i.
MetaCoq Erase ((fun (X : Set) (x : X) => x) nat).

(** Check that optimization of singleton pattern-matchings work *)
MetaCoq Erase ((fun (X : Set) (x : X) (e : x = x) =>
                  match e in eq _ x' return bool with
                  | eq_refl => true
                  end)).
