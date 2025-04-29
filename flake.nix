{
  description = "Neovim derivation";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    cfn-lsp-extra = {
      url = "github:LaurenceWarne/cfn-lsp-extra?ref=refs/tags/v0.7.2";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, cfn-lsp-extra }:
    let
      cfn-lsp-extra-overlay = import ./nix/overlays/cfn-lsp-extra.nix { cfn-lsp-extra = cfn-lsp-extra; };
      pkgs = import nixpkgs {
        system = "aarch64-darwin";
        overlays = [
          cfn-lsp-extra-overlay
        ];
      };
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
          # notify
          nvim-notify
          # colorscheme
          tokyonight-nvim
          # lualine
          lualine-nvim
          # which-key
          which-key-nvim
          # file handling
          bigfile-nvim
          hex-nvim
          # tmux
          vim-tmux-navigator
          # treesitter
          nvim-treesitter.withAllGrammars
          nvim-treesitter-textobjects
          nvim-ts-autotag
          # nvim-tree
          nvim-tree-lua
          nvim-web-devicons
          # comment
          comment-nvim
          nvim-ts-context-commentstring
          # undotree
          undotree
          # telescope
          telescope-nvim
          telescope-fzf-native-nvim
          # harpoon
          harpoon2
          # images
          image-nvim
          # git
          vim-fugitive
          vim-rhubarb
          gitsigns-nvim
          # code
          trouble-nvim
          nvim-coverage
          nvim-dap
          nvim-dap-ui
          nvim-nio
          nvim-dap-virtual-text
          conform-nvim
          nvim-lint
          # language-specific tools
          tailwind-tools-nvim
          # tsc-nvim # todo set this up, add ts-error-translator
          # cmp, snippets
          nvim-cmp
          cmp-buffer
          cmp-path
          luasnip
          cmp_luasnip
          friendly-snippets
          # lsp
          nvim-lspconfig
          cmp-nvim-lsp
          nvim-lsp-file-operations
          # marilari88/twoslash-queries.nvim # todo add
          # ai
          copilot-lua
          CopilotChat-nvim
          copilot-cmp
          avante-nvim
        ];
        extraPackages = [
          pkgs.imagemagick
          pkgs.fzf
          pkgs.stylua
          pkgs.nodePackages.prettier
          pkgs.black
          pkgs.actionlint
          pkgs.nixfmt-rfc-style
          pkgs.vscode-js-debug
          pkgs.typescript-language-server
          pkgs.vscode-langservers-extracted
          pkgs.gopls
          pkgs.lua-language-server
          pkgs.docker-language-server
          pkgs.dockerfile-language-server-nodejs
          pkgs.docker-compose-language-service
          pkgs.dot-language-server
          pkgs.pyright
          pkgs.templ
          pkgs.nil
          pkgs.bash-language-server
          pkgs.tailwindcss-language-server
          pkgs.glsl_analyzer
          pkgs.python3Packages.cfn-lsp-extra
          # todo: amazon-states-language-service
        ];
        extraLuaPackages =
          luaPkgs: with luaPkgs; [
            magick
          ];
      };
      apps.aarch64-darwin.default = {
        type = "app";
        program = "${self.packages.aarch64-darwin.default}/bin/nvim";
      };
    };
}
