module Ex04d

val append : list 'a -> list 'a -> Tot (list 'a)
let rec append xs ys = match xs with
  | []      -> ys
  | x :: xs' -> x :: append xs' ys


val reverse : list 'a -> Tot (list 'a)
let rec reverse = function
  | []     -> []
  | x :: xs -> append (reverse xs) [x]


val snoc : list 'a -> 'a -> Tot (list 'a)
let snoc xs x = append xs [x]


val snoc_cons : xs:list 'a -> x:'a -> Lemma (reverse (snoc xs x) == x :: reverse xs)
let rec snoc_cons xs x = match xs with
  | []      -> ()
  | _ :: xs' -> snoc_cons xs' x


val rev_involutive : xs:list 'a -> Lemma (reverse (reverse xs) == xs)
let rec rev_involutive = function
  | []     -> ()
  | x :: xs ->
    rev_involutive xs;
    snoc_cons (reverse xs) x


val rev_injective : xs:list 'a -> ys:list 'a
		  -> Lemma (requires (reverse xs == reverse ys))
			  (ensures  (xs == ys))
let rev_injective #a xs ys =
  rev_involutive xs;
  rev_involutive ys
