let ( let+? ) x f = Option.map f x

let ( let*? ) x f = Option.bind x f

let ( let*! ) x f =
  let x = try Ok x with e -> Error e in
  f x

let ( let++ ) x f = Result.map f x

let ( let+- ) x f = Result.map_error f x

let ( let*+ ) x f = Result.bind x f
