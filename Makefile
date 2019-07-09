# Frontend to dune.

ENV = opam config exec --

.PHONY: default build install uninstall test clean

default: build

build:
	${ENV} dune build

test:
	${ENV} dune runtest -f

install:
	${ENV} dune install

uninstall:
	${ENV} dune uninstall

clean:
	${ENV} dune clean
# Optionally, remove all files/folders ignored by git as defined
# in .gitignore (-X).
# 	git clean -dfXq
