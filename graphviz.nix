{
  mkDerivation,
  lib,
  pkg-config,
  expat,
  gdSupport ? true,
  gd,
}:
mkDerivation {
  name = "graphviz";
  src = ./graphviz-9.0.0.tar.gz;
  buildInputs =
    [pkg-config (lib.getDev expat)]
    ++ lib.optional gdSupport (lib.getDev gd)
    ++ lib.optional gdSupport (lib.getLib gd);
}
