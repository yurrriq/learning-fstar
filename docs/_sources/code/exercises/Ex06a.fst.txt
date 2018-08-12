module Ex06a


val partition: ('a -> Tot bool) -> list 'a -> Tot (list 'a * list 'a)
let rec partition pred = function
  | []   -> [], []
  | x::xs ->
    let ys, zs = partition pred xs in
    if pred x
      then x::ys, zs
      else ys,   x::zs
