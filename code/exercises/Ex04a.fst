module Ex04a


val length : list 'a -> Tot nat
let rec length l = match l with
  | []     -> 0
  | _ :: tl -> 1 + length tl


val append : xs:list 'a -> ys:list 'a -> Tot (zs:list 'a{length zs = length xs + length ys})
let rec append xs ys = match xs with
  | []      -> ys
  | x :: xs' -> x :: append xs' ys
