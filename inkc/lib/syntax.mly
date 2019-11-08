%token EOF
%token COLON
%token LSQUARE RSQUARE
%token<string> IDENT

%start <string list> idents

%%

let idents :=
  | LSQUARE; idents = separated_list(COLON, ident); RSQUARE; EOF; { idents }

let ident :=
  | ~ = IDENT; <>
