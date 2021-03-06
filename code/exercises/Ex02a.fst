/// ***********
/// Exercise 2a
/// ***********

(**
@summary Verified programming in F*: Exercise 2a
*)
module Ex02a


/// Type Synonyms
/// =============
///
/// Define a type synonym to model `filename`_\ s as ``string``\ s.
///
/// .. _filename:

(** A filename is a string. *)
type filename = string


/// Access Control Predicates
/// =========================
///
/// For this exercise, the file ``demo/tempfile`` is writeable and all
/// others are not.
///
/// .. _canWrite:

(** Determine whether a file can be written. *)
val canWrite : filename -> Tot bool
let canWrite = function
  | "demo/tempfile" -> true
  | _               -> false


/// A file is considered readable if it either satisfies `canWrite`_
/// or is ``demo/README``.
///
/// .. _canRead:

(** Determine if a file can be read. *)
val canRead : filename -> Tot bool
let canRead (f:filename) =
  canWrite f ||
  f = "demo/README"
