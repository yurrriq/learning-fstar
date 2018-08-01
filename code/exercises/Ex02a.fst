module Ex02a


type filename = string


(** [canWrite] is a function specifying whether a file [f] can be written. *)
val canWrite : filename -> Tot bool
let canWrite (f:filename) =
  match f with
    | "demo/tempfile" -> true
    | _               -> false


(** [canRead] is a function specifying whether a file [f] can be read. *)
val canRead : filename -> Tot bool
let canRead (f:filename) =
  canWrite f ||
  f = "demo/README"
