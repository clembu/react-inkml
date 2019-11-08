open Cmdliner
open Fpsyntax

let inkc file =
  let inkc_res file =
    let>& ic =
      try Ok (open_in file) with Sys_error err -> Error (`SysError err)
    in
    let>& s = Inkc.Parser.parse_chan ic >|! fun e -> `ParseError e in
    let|& () =
      try Ok (close_in ic) with Sys_error err -> Error (`SysError err)
    in
    List.iter print_endline s
  in
  inkc_res file
  >|! function
  | `ParseError report ->
      Location.print_report Format.err_formatter report ;
      `ParseError report
  | `SysError e ->
      Format.eprintf "\027[1m\027[31mSystem Error\027[0m: %s" e ;
      `SysError e

(* match s with
 * | Ok s -> Format.printf "Hello, %s!@." (String.of_seq (List.to_seq s))
 * | Error (`SysError es | `ParseError es) ->
 *     Format.eprintf "An error occured: %s@." es *)

let file_t =
  let doc = "The master ink file to compile" in
  let open Arg in
  required & pos 0 (some non_dir_file) None & info ~doc ~docv:"FILE" []

let inkc_t =
  let open Term in
  const inkc $ file_t

let inkc_inf =
  let doc = "An Ink compiler written in OCaml" in
  let man =
    [ `S Manpage.s_bugs
    ; `P
        "File issues on github at \
         <https://github.com/facelesspanda/react-inkml/issues>" ]
  in
  Term.info "inkc" ~man ~doc ~exits:Term.default_exits

let () = Term.exit @@ Term.eval (inkc_t, inkc_inf)
