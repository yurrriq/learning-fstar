module Ex03c

open FStar.Mul


val fibonacci : nat -> Tot (m : nat{m > 0})
let rec fibonacci n =
  if n <= 1
    then 1
    else fibonacci (n - 1) + fibonacci (n - 2)


val fibonacci_greater_than_arg : n:nat{ n >= 2} -> Lemma (fibonacci n >= n)
let rec fibonacci_greater_than_arg n =
  match n with
  | 2 -> ()
  | _ -> fibonacci_greater_than_arg (n - 1)
