let
  fetchNixpkgs =
    { owner ? "NixOS", repo ? "nixpkgs", rev, sha256 }:
    builtins.fetchTarball {
      url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
      inherit sha256;
    };

  importJSON = path: builtins.fromJSON (builtins.readFile path);
in

{ nixpkgs ? fetchNixpkgs (importJSON ./nixpkgs-src.json) }:

with import nixpkgs {
  config = {
    packageOverrides = super: rec {
      fstar = (super.fstar.overrideDerivation (old: {
        postPatch = ''
          substituteInPlace ulib/Makefile \
              --replace 'OCAMLPATH=../../../bin/' 'OCAMLPATH+=:../../../bin/'
            '';
        preInstall = ''
          mkdir -p $out/lib/ocaml/${super.ocaml.version}/site-lib/fstarlib
          make -C src fstarlib
          make -C ulib/ml
        '';
        installFlags = "-C src/ocaml-output ulib";
      })).override {
        ocamlPackages = super.ocaml-ng.ocamlPackages_4_05;
      };
      ocamlPackages = super.ocaml-ng.ocamlPackages_4_05;
      inherit (ocamlPackages) ocaml;
    };
  };
};

let
  customEmacs = emacsPackagesNg.emacsWithPackages (epkgs: with epkgs.melpaPackages; [
    fill-column-indicator
    fstar-mode
    hl-todo
    whitespace-cleanup-mode
  ]);
  visitors = callPackage ./nix/pkgs/development/ocaml-modules/visitors {
    inherit (ocamlPackages)
      cppo findlib ocamlbuild ppx_deriving ppx_tools;
  };
  kremlin = callPackage ./nix/pkgs/development/fstar-modules/kremlin {
    inherit fstar ocaml visitors which;
    inherit (ocamlPackages)
      batteries findlib fix menhir ocamlbuild pprint ppx_deriving ppx_deriving_yojson
      process stdint ulex wasm zarith;
  };
in

stdenv.mkDerivation rec {
  name = "learning-fstar-${version}";
  version = builtins.readFile ./VERSION;
  src = ./.;

  HOME = src;

  configurePhase = ''
    addToSearchPath OCAMLPATH "${fstar}/lib/ocaml/${ocaml.version}/site-lib/"
  '';

  makeFlags = [ "PREFIX=$(out)" ];

  preBuild = ''
    install -dm755 $out/lib
    install -dm755 $out/share
    # install -dm755 $out/bin
  '';

  postBuild = ''
    make -f Makefile.sphinx html
  '';

  buildInputs = [
    customEmacs
    fstar
    iosevka
    kremlin
    ocaml
    python2
    z3
  ] ++ (with ocamlPackages; [
    batteries
    findlib
    ppx_deriving
    ppx_deriving_yojson
    stdint
    zarith
  ]) ++ (with python2Packages; [
    docutils
    sphinx
  ]);

  installPhase = ''
    cp -r _build/html $out/share/
  '';

  shellHook = ''
    export PATH="$PATH:${emacsPackagesNg.melpaPackages.fstar-mode}/share/emacs/site-lisp/elpa/fstar-mode-${emacsPackagesNg.melpaPackages.fstar-mode.version}/etc/fslit"
  '';
}
