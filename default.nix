{pkgs ? null}: let
  inputs = import ./_sources/generated.nix {
    fetchurl = null;
    fetchgit = null;
    fetchFromGitHub = null;
    dockerTools = null;
  };
  finalPkgs =
    if pkgs != null
    then pkgs
    else
      import inputs.nixpkgs.src {
        config.allowUnfree = true;
      };
  vim-dir = ./config;
  vimRcFile = builtins.concatStringsSep "\n" (
    map (f: builtins.readFile (vim-dir + "/${f}"))
    (builtins.attrNames (builtins.readDir vim-dir))
  );
in (import ./package.nix {
  pkgs = finalPkgs;
  inherit vimRcFile;
})
