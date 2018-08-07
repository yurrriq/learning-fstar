{ stdenv, fetchFromGitHub
, fstar, ocaml, which
, batteries, findlib, fix, menhir, ocamlbuild, pprint, ppx_deriving, ppx_deriving_yojson
, process, stdint, ulex, visitors, wasm, zarith
}:

stdenv.mkDerivation rec {
  name = "kremlin-${version}";
  version = "0.9.6.0";
  src = fetchFromGitHub {
    owner = "FStarLang";
    repo = "kremlin";
    rev = "v${version}";
    sha256 = "1pn5wm8ssfvnbwhnfi7h143gi1r3yvp4303rhgdqwl532zg3minw";
  };

  postPatch = ''
    sed -Ei 's|OCAMLPATH=[^[:space:]]+||' Makefile
    sed -i -e 's|"ulib"|"lib" ^^ "fstar"|' \
           -e 's|"--cache_checked_modules";|"--cache_checked_modules"; "--cache_dir"; "./.cache/";|' \
           src/Driver.ml
  '';

  makeFlags = [ "PREFIX=$(out)" ];

  buildInputs = [
    fstar
    ocaml
    ocamlbuild
    which

    batteries
    findlib
    fix
    menhir
    pprint
    ppx_deriving
    ppx_deriving_yojson
    process
    stdint
    ulex
    visitors
    wasm
    zarith
  ];
}
