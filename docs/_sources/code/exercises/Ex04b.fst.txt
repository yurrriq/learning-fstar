module Ex04b


val length : list 'a -> Tot nat
let rec length l = match l with
  | []     -> 0
  | _ :: tl -> 1 + length tl


val append : list 'a -> list 'a -> Tot (list 'a)
let rec append xs ys = match xs with
  | []      -> ys
  | x :: xs' -> x :: append xs' ys


val append_len : xs:list 'a -> ys:list 'a
	       -> Lemma (requires True)
		       (ensures (length (append xs ys) = length xs + length ys))
let rec append_len xs ys = match xs with
  | [] -> ()
  | x :: xs' -> append_len xs' ys
