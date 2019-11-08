(lang dune 1.11)
(name ink)
(version 0.0.0)

(generate_opam_files true)
(using menhir 2.0)

(source (github facelesspanda/react-inkml))
(license MIT)
(authors "Clément Busschaert")
(maintainers "clement.busschaert@gmail.com")

(package
 (name ink)
 (synopsis "The Ink runtime library")
 (description "A reactive functional programming interface to drive Ink stories
written with Inklestudios' Ink language")
 (depends dune react uutf uucp angstrom cmdliner fp-syntax fp-syntax_react))

(package
 (name ink-player)
 (synopsis "A cli Ink player")
 (description "An Ink player for the terminal")
 (depends dune ink react))
