STDLIB_REALIZED=All Heap List Set
FSTAR=fstar.exe
FSTARFLAGS=--codegen OCaml $(addprefix --no_extract ,$(STDLIB_REALIZED))
FSTFILES := $(wildcard code/exercises/*.fst)
BIN_DIR := ${PREFIX}/bin
LIB_DIR := ${PREFIX}/lib
MLFILES := $(addprefix  ${LIB_DIR}/, $(notdir ${FSTFILES:.fst=.ml}))


${LIB_DIR}/%.ml: code/exercises/%.fst
	${FSTAR} ${FSTARFLAGS} --odir $(dir $@) $<


${BIN_DIR}/%: ${LIB_DIR}/%.ml
	ocamlfind c -package fstarlib -linkpkg -g $<


.PHONY: all

all: ${MLFILES} # $(addprefix ${BIN_DIR}/, $(notdir ${MLFILES:.ml=}))


.PHONY: docs

docs:
	@ rm -fR $@/*
	@ cp -fR --no-preserve=ownership,mode $$(nix-build --no-out-link)/share/html/* $@/
	@ touch $@/.nojekyll
