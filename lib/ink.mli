(** {1:ink Ink machines} *)

type t
(** The type for initialized ink machines. *)

(** {2:inkload Creating machines}

    The following functions are used to initialize machines from ink
    programs.*)

val ink_of_file : string -> t
(** [ink_of_file path] reads the json file at [path] and creates an ink
    machine with the program described in that file.*)
