{ lib }:
{
  /*
    Got from the following github file https://github.com/gvolpe/nix-config/blob/12807b7fd37fe3d1b3799c673e2bc497998c8402/lib/default.nix
    Get the first regular file inside bin directory or meta main program for executable file
  */
  exe =
    drv:
    let
      regFiles = lib.mapAttrsToList (f: _: f) (
        lib.filterAttrs (_: t: t == "regular") (builtins.readDir "${drv}/bin")
      );
      mainProg = drv.meta.mainProgram or (lib.head regFiles);
    in
    "${drv}/bin/${mainProg}";
}
