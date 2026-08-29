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
  vimRcFile = finalPkgs.runCommand "vimrc.vim" {} ''
    cat ${vim-dir}/* > $out
  '';
in
  (import ./package.nix {
    pkgs = finalPkgs;
    inherit vimRcFile;
  })
