module Ex01a

open FStar.Exn
open FStar.All


type filename = string


(** [canWrite] is a function specifying whether a file [f] can be written. *)
let canWrite (f:filename) =
  match f with
    | "demo/tempfile" -> true
    | _               -> false


(** [canRead] is a function specifying whether a file [f] can be read. *)
let canRead (f:filename) =
  canWrite f ||
  f = "demo/README"


let read f = FStar.IO.print_string ("Dummy read of file " ^ f ^ "\n"); f


let write f s = FStar.IO.print_string ("Dummy write of string " ^ s ^ " to file " ^ f ^ "\n")


let passwd : filename = "demo/password"
let readme : filename = "demo/README"
let tmp    : filename = "demo/tempfile"


let staticChecking () =
  let v1 = read tmp in
  let v2 = read readme in
  (* let v3 = read passwd in // invalid read *)
  write tmp "hello!"
  (* ; write passwd "junk" // invalid write *)


exception InvalidRead
let checkedRead f =
  if canRead f
    then read f
    else raise InvalidRead


(* Exercise 1a *)
exception InvalidWrite
let checkedWrite f s =
  if canWrite f
    then write f s
    else raise InvalidWrite


let dynamicChecking () =
  let v1 = checkedRead tmp in
  let v2 = checkedRead readme in
  let v3 = checkedRead passwd in
  checkedWrite tmp "hello!";
  checkedWrite passwd "junk"


let main = staticChecking (); dynamicChecking ()
