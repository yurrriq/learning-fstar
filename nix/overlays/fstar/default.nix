self: super: rec {

  fstar = (super.fstar.overrideDerivation (old: {
    postPatch = ''
      substituteInPlace ulib/Makefile \
          --replace 'OCAMLPATH=../../../bin/' 'OCAMLPATH+=:../../../bin/'
    '';

    preInstall = ''
      mkdir -p $out/lib/ocaml/${self.ocaml.version}/site-lib/fstarlib
      make -C src fstarlib
      make -C ulib/ml
    '';

    installFlags = "-C src/ocaml-output ulib";

    buildInputs = old.buildInputs ++ [ self.which ];
  })).override { inherit (self) ocamlPackages; };

  kremlin = super.callPackage ../../pkgs/development/fstar-modules/kremlin {
    inherit fstar;
    inherit (self.ocamlPackages)
      batteries findlib fix menhir ocaml ocamlbuild pprint ppx_deriving
      ppx_deriving_yojson process stdint ulex visitors wasm zarith;
  };

}
