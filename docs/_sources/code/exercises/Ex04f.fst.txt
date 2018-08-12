module Ex04f


val fold_left: f:('b -> 'a -> Tot 'a) -> list 'b -> 'a -> Tot 'a
let rec fold_left f lst z = match lst with
  | Nil       -> z
  | Cons x xs -> fold_left f xs (f x z)


val append : list 'a -> list 'a -> Tot (list 'a)
let rec append xs ys = match xs with
  | []      -> ys
  | x :: xs' -> x :: append xs' ys


val snoc : list 'a -> 'a -> list 'a
let snoc xs x = append xs [x]


val reverse: list 'a -> Tot (list 'a)
let rec reverse = function
  | []     -> []
  | x :: xs -> snoc (reverse xs) x


(* A proof that [append] is associative. *)
val append_is_associative : #a:Type ->
    xs:list a -> ys:list a -> zs:list a ->
    Lemma (append xs (append ys zs) == append (append xs ys) zs)
let rec append_is_associative #a xs ys zs = match xs with
  | []      -> ()
  | x :: xs' -> append_is_associative xs' ys zs


val fold_left_cons_is_reverse : xs:list 'a -> ys:list 'a ->
    Lemma (fold_left Cons xs ys == append (reverse xs) ys)
let rec fold_left_cons_is_reverse xs ys = match xs with
  | [] -> ()
  | x :: xs' ->
    append_is_associative (reverse xs') [x] ys;
    fold_left_cons_is_reverse xs' (x :: ys)
