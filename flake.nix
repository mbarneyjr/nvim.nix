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
        withPython3 = true;
        withRuby = true;
        withNodeJs = true;
        withSqlite = true;
        viAlias = true;
        vimAlias = true;
        plugins = with pkgs.vimPlugins; [
          tokyonight-nvim
          image-nvim
          nvim-treesitter.withAllGrammars
          # avante-nvim
          # bigfile-nvim
          # comment-nvim
          # nvim-ts-context-commentstring
          # copilot-lua
          # CopilotChat-nvim
          # copilot-cmp
          # nvim-coverage
          # nvim-dap
          # nvim-dap-ui
          # nvim-dap-virtual-text
          # conform-nvim
          # vim-fugitive
          # vim-rhubarb
          # gitsigns-nvim
          # harpoon # todo upgrade to harpoon2
          # hex-nvim
          # nvim-lint
          # lualine-nvim
          # nvim-notify
          # nvim-cmp
          # cmp-buffer
          # cmp-path
          # luasnip
          # cmp_luasnip
          # friendly-snippets
          # nvim-web-devicons
          # nvim-tree-lua
          # nvim-surround
          # tailwind-tools-nvim
          # telescope-nvim
          # telescope-fzf-native-nvim
          # trouble-nvim
          # tsc-nvim
          # undotree
          # vim-tmux-navigator
          # which-key-nvim
          # todo add marilari88/twoslash-queries.nvim
        ];
        extraPackages = [
          pkgs.imagemagick
          pkgs.fzf
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
