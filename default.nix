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

with import nixpkgs {};

stdenv.mkDerivation rec {
  name = "learning-fstar-${version}";
  version = builtins.readFile ./VERSION;
  src = ./.;
  HOME = src;
  buildInputs = [
    fstar
    ((emacsPackagesNgGen emacs).emacsWithPackages (epkgs:
      with epkgs.melpaPackages; [
        fstar-mode
      ]))
  ];
}
