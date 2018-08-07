module Ex01a


val canRead : filename -> bool

val read : f:filename{canRead f} -> ML string

val checkedRead : filename -> ML string


val canWrite : filename -> bool

val write : f:filename{canWrite f} -> string -> ML unit

val checkedWrite : filename -> string -> ML unit


val staticChecking : unit -> ML unit
