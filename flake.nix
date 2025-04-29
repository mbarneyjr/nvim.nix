{
  description = "Neovim derivation";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{ self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "aarch64-darwin"; };
      mkNeovim = pkgs.callPackage ./nix/mkNeovim.nix { };
    in
    {
      packages.aarch64-darwin.default = mkNeovim {
        plugins = with pkgs.vimPlugins; [
          tokyonight-nvim
          image-nvim
        ];
        extraLuaPackages = luaPkgs: with luaPkgs; [
          magick
        ];
      };
      apps.aarch64-darwin.default = {
        type = "app";
        program = "${self.packages.aarch64-darwin.default}/bin/nvim";
      };
    };
}
