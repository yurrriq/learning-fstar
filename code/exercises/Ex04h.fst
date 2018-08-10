module Ex04h

// open Ex04g


val length : list 'a -> Tot nat
let rec length = function
  | []     -> 0
  | _ :: xs -> 1 + length xs



(* Return the nth element of a list with at least n elements. *)
val nth : lst:list 'a -> n:nat{n < length lst} -> 'a
let rec nth lst n =
  match lst with
  | x :: xs -> if n = 0 then x else nth xs (n - 1)
