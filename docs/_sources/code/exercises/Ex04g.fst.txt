module Ex04g


val hd : xs:list 'a{Cons? xs} -> Tot 'a
let hd = function
  | x :: _ -> x


val tl : xs:list 'a{Cons? xs} -> Tot (list 'a)
let tl = function
  | _ :: xs -> xs
