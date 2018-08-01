module Ex04c


val append : list 'a -> list 'a -> Tot (list 'a)
let rec append xs ys = match xs with
  | []      -> ys
  | x :: xs' -> x :: append xs' ys


val mem : #a:eqtype -> a -> list a -> Tot bool
let rec mem #a x xs =
  match xs with
  | []       -> false
  | x' :: xs' -> x' = x || mem x xs'


val append_mem : #a:eqtype -> xs:list a -> ys:list a -> x:a
               -> Lemma (mem x (append xs ys) <==> mem x xs || mem x ys)
let rec append_mem #a xs ys x =
  match xs with
  | []       -> ()
  | x' :: xs' -> append_mem xs' ys x

