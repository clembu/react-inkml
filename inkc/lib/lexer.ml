open Sedlexing

type token = Syntax.token

open Syntax

exception LexError of (Lexing.position * Lexing.position) * string

let blank = [%sedlex.regexp? ' ' | '\t']

let newline = [%sedlex.regexp? '\r' | '\n' | "\r\n"]

let any_blank = [%sedlex.regexp? blank | newline]

let rec nom buf =
  match%sedlex buf with Plus any_blank -> nom buf | _ -> ()

let token buf =
  nom buf ;
  match%sedlex buf with
  | eof -> EOF
  | "" -> EOF
  | ':' -> COLON
  | '[' -> LSQUARE
  | ']' -> RSQUARE
  | xid_start, Star xid_continue -> IDENT (Utf8.lexeme buf)
  | _ ->
      let positions = lexing_positions buf in
      let tok = Utf8.lexeme buf in
      raise
      @@ LexError (positions, Printf.sprintf "unexpected character %S" tok)

let lexer buf = Sedlexing.with_tokenizer token buf
