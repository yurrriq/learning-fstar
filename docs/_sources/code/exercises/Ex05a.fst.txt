module Ex05a


val append : list 'a -> list 'a -> Tot (list 'a)
let rec append xs ys = match xs with
  | []      -> ys
  | x :: xs' -> x :: append xs' ys


val snoc : list 'a -> 'a -> list 'a
let snoc xs x = append xs [x]


val reverse : list 'a -> Tot (list 'a)
let rec reverse = function
  | []     -> []
  | x :: xs -> snoc xs x


val rev : xs:list 'a -> ys:list 'a -> Tot (list 'a) (decreases ys)
let rec rev xs = function
  | []     -> xs
  | y :: ys -> rev (y :: xs) ys


(* A proof that [append] is associative. *)
val append_is_associative : xs:list 'a -> ys:list 'a -> zs:list 'a ->
    Lemma (ensures (append xs (append ys zs) == append (append xs ys) zs))
let rec append_is_associative #a xs ys zs = match xs with
  | []      -> ()
  | x :: xs' -> append_is_associative xs' ys zs


val append_nil_right_neutral : #a:eqtype -> xs:list a -> Lemma (ensures (append xs [] = xs))
let rec append_nil_right_neutral #a = function
  | [] -> ()
  | _ :: xs -> admit()


assume val rev_is_ok' : #a:eqtype -> xs:list a -> ys:list a -> Lemma
    (ensures (rev xs ys = append (reverse ys) xs)) (decreases ys)


// val rev_is_ok : #a:eqtype -> xs:list a -> Lemma (rev [] xs = reverse xs)
// let rev_is_ok #a xs = rev_is_ok' #a [] xs
