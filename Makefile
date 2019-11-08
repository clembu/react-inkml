# Frontend to dune.

ENV = opam config exec --
SYNTAX_FILE = inkc/lib/syntax

.PHONY: default build install uninstall test doc syntax-errors clean

default: build

build:
	${ENV} dune build

test:
	${ENV} dune runtest -f

install:
	${ENV} dune install

uninstall:
	${ENV} dune uninstall

doc:
	${ENV} dune build @doc

syntax-errors:
	${ENV} menhir --list-errors ${SYNTAX_FILE}.mly >> ${SYNTAX_FILE}.messages

clean:
	${ENV} dune clean
# Optionally, remove all files/folders ignored by git as defined
# in .gitignore (-X).
# 	git clean -dfXq
