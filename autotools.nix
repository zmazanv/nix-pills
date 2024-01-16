pkgs: attrs: let
  defaultAttrs = {
    builder = "${pkgs.bash}/bin/bash";
    args = [./builder.sh];
    setup = ./setup.sh;
    baseInputs = with pkgs; [
      binutils.bintools
      coreutils
      findutils
      gawk
      gcc
      gnugrep
      gnumake
      gnused
      gnutar
      gzip
      patchelf
    ];
    buildInputs = [];
    system = builtins.currentSystem;
  };
in
  derivation (defaultAttrs // attrs)
