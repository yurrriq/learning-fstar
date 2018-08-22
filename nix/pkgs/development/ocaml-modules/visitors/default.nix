{ stdenv, fetchgit, coreutils, ocaml
, cppo, findlib, ocamlbuild, ppx_deriving, ppx_tools
}:

stdenv.mkDerivation rec {
  name = "visitors-${version}";
  version = "20180306";

  src = fetchgit {
    url = "https://gitlab.inria.fr/fpottier/visitors.git";
    rev = version;
    sha256 = "1ym79yjz67fvwx6qlz70v7d74b6hy7mxrbwbgrp986c6n96qs3x9";
  };

  preBuild = ''
    substituteInPlace GNUmakefile \
        --replace /bin/date ${coreutils}/bin/date
  '';
  createFindlibDestdir = true;
  buildInputs = [
    ocaml
    cppo findlib ocamlbuild ppx_deriving ppx_tools
  ];

  meta = with stdenv.lib; {
    longDescription = ''
      An OCaml syntax extension (technically, a ppx_deriving plugin)
      which generates object-oriented visitors for traversing and
      transforming data structures.
    '';
    license = licenses.gpl2;
    maintainers = with maintainers; [ yurrriq ];
    inherit (src.meta) homepage;
    inherit (ocaml.meta) platforms;
  };
}
