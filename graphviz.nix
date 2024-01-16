let
  pkgs = import <nixpkgs> {};
  mkDerivation = import ./autotools.nix pkgs;
in
  mkDerivation {
    name = "graphviz";
    src = ./graphviz-9.0.0.tar.gz;
    buildInputs = with pkgs; [
      pkg-config
      (pkgs.lib.getDev expat)
      (pkgs.lib.getDev gd)
      (pkgs.lib.getLib gd)
    ];
  }
