let
  inputs = import ./_sources/generated.nix {
    fetchurl = null;
    fetchgit = null;
    fetchFromGitHub = null;
    dockerTools = null;
  };
  pkgs = import inputs.nixpkgs.src {
    config.allowUnfree = true;
  };
  vim-dir = ./config;
  vimRcFile = pkgs.runCommand "vimrc.vim" {} ''
    cat ${vim-dir}/* > $out
  '';
in
(import ./package.nix {inherit pkgs vimRcFile;})
