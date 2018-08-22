self: super: rec {

  inherit (ocamlPackages) ocaml;

  ocamlPackages = self.ocaml-ng.ocamlPackages_4_05 // {
    visitors = super.callPackage ../../pkgs/development/ocaml-modules/visitors {
      inherit ocaml;
      inherit (ocamlPackages) cppo findlib ocamlbuild ppx_deriving ppx_tools;
    };
  };

}
