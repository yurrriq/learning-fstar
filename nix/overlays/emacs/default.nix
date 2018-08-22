self: super: {

  emacs = super.emacsPackagesNg.emacsWithPackages (epkgs: with epkgs.melpaPackages; [
    fill-column-indicator
    fstar-mode
    hl-todo
    whitespace-cleanup-mode
  ]);

}
