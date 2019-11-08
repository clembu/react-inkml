module I = Syntax.MenhirInterpreter
module L = Location

let state = function
  | I.HandlingError env -> I.current_state_number env
  | _ ->
      Printf.fprintf stderr "Checkpoint was not HandlingError" ;
      assert false

let succeed s = Ok s

let mkloc (loc_start, loc_end) =
  Warnings.{loc_start; loc_end; loc_ghost= false}

let fail lexbuf cp =
  let loc = Sedlexing.lexing_positions lexbuf |> mkloc in
  match Syntax_error.message (state cp) with
  | exception Not_found -> Error (L.error ~loc "Syntax error")
  | msg -> Error (L.error ~loc msg)

let loop lexbuf result =
  I.loop_handle succeed (fail lexbuf) (Lexer.lexer lexbuf) result

let process buf =
  try
    loop buf
      (Syntax.Incremental.idents @@ fst (Sedlexing.lexing_positions buf))
  with Lexer.LexError (loc, msg) -> Error (L.error ~loc:(mkloc loc) msg)

let parse_chan ic = process @@ Sedlexing.Utf8.from_channel ic
