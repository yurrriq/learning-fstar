module Ex04e


type option 'a =
  | None : option 'a
  | Some : v:'a -> option 'a


val find : ('a -> Tot bool) -> list 'a -> Tot (option 'a)
let rec find pred = function
  | []     -> None
  | x :: xs -> if pred x then Some x else find pred xs


val find' : #t:Type -> f:(t -> Tot bool) -> list t -> Tot (option t)
let rec find' #t pred = function
  | []     -> None
  | x :: xs -> if pred x then Some x else find' pred xs


val find_some : pred:('a -> Tot bool) -> lst:(list 'a) ->
    Lemma (None? (find pred lst) || pred (Some?.v (find pred lst)))
 (* Lemma (match find pred lst with
	   | None   -> true
	   | Some v -> pred v) *)
let rec find_some pred = function
  | []     -> ()
  | x :: xs -> find_some pred xs
