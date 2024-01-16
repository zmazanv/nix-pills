let
  pkgs = import <nixpkgs> {};
  mkDerivation = import ./autotools.nix pkgs;
in
  with pkgs; {
    hello = import ./hello.nix mkDerivation;

    graphviz = import ./graphviz.nix {inherit mkDerivation lib pkg-config expat gd;};

    graphvizCore = import ./graphviz.nix {
      inherit mkDerivation lib pkg-config expat gd;
      gdSupport = false;
    };
  }
