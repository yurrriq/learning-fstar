let

  fetchTarballFromGitHub =
    { owner, repo, rev, sha256, ... }:
    builtins.fetchTarball {
      url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
      inherit sha256;
    };

  fromJSONFile = f: builtins.fromJSON (builtins.readFile f);

in

{ nixpkgs ? fetchTarballFromGitHub (fromJSONFile ./nix/srcs/nixpkgs.json) }:

with import nixpkgs {

  overlays = [
    (import ./nix/overlays/ocaml)
    (import ./nix/overlays/fstar)
    (import ./nix/overlays/emacs)
  ];
};

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
    emacs
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
