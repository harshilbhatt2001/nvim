{
  description = "Neovim, config and plugins fully pinned by nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    wrappers.url = "github:BirdeeHub/nix-wrapper-modules";

    # Plugins not in nixpkgs, pinned as flake inputs.
    tomorrow-nvim = {
      url = "github:paul-han-gh/tomorrow.nvim";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    # allowUnfree: cmp-calc (and possibly future plugins) carry an unfree
    # license marker in nixpkgs.
    forAllSystems = f:
      nixpkgs.lib.genAttrs supportedSystems (system:
        f (import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }));

    # Every plugin the lazy.nvim specs in lua/plugins/ reference, provided by
    # nix. lazy resolves each plugin to <farm>/<name> via dev.path (see
    # lua/config/lazy.lua), so each key here must match lazy's name for the
    # plugin: the repo basename, or the spec's `name =` override.
    lazyPlugins = pkgs: let
      vp = pkgs.vimPlugins;

      # nvim-treesitter with every grammar precompiled — replaces :TSUpdate /
      # auto_install. Grammars live in separate plugin drvs; merge them into
      # the plugin's own dir so lazy sees one plugin with all parsers.
      treesitter = pkgs.symlinkJoin {
        name = "nvim-treesitter-with-grammars";
        paths =
          [vp.nvim-treesitter.withAllGrammars]
          ++ vp.nvim-treesitter.withAllGrammars.dependencies;
      };

      fromInput = pname: src:
        pkgs.vimUtils.buildVimPlugin {
          inherit pname src;
          version = toString (src.lastModifiedDate or "flake");
          doCheck = false;
        };
    in {
      "lazy.nvim" = vp.lazy-nvim;
      "plenary.nvim" = vp.plenary-nvim;

      # completion
      "nvim-cmp" = vp.nvim-cmp;
      "cmp-nvim-lsp" = vp.cmp-nvim-lsp;
      "cmp-nvim-lsp-signature-help" = vp.cmp-nvim-lsp-signature-help;
      "cmp-buffer" = vp.cmp-buffer;
      "cmp-path" = vp.cmp-path;
      "cmp-git" = vp.cmp-git;
      "cmp-calc" = vp.cmp-calc;
      "cmp-cmdline" = vp.cmp-cmdline;
      "cmp_luasnip" = vp.cmp_luasnip;
      "LuaSnip" = vp.luasnip;
      "friendly-snippets" = vp.friendly-snippets;

      # colourschemes
      "rose-pine" = vp.rose-pine;
      "gruvbox" = vp.gruvbox-nvim;
      "tomorrow.nvim" = fromInput "tomorrow.nvim" inputs.tomorrow-nvim;

      # git
      "neogit" = vp.neogit;
      "diffview.nvim" = vp.diffview-nvim;
      "vim-fugitive" = vp.vim-fugitive;
      "todo-comments.nvim" = vp.todo-comments-nvim;

      # lsp
      "nvim-lspconfig" = vp.nvim-lspconfig;
      "neodev.nvim" = vp.neodev-nvim;

      # ui / editing
      "telescope.nvim" = vp.telescope-nvim;
      "telescope-ui-select.nvim" = vp.telescope-ui-select-nvim;
      "telescope-fzf-native.nvim" = vp.telescope-fzf-native-nvim;
      "harpoon" = vp.harpoon2;
      "nvim-treesitter" = treesitter;
      "render-markdown.nvim" = vp.render-markdown-nvim;
      "nvim-web-devicons" = vp.nvim-web-devicons;
      "which-key.nvim" = vp.which-key-nvim;
      "FTerm.nvim" = vp.FTerm-nvim;
      "claude-code.nvim" = vp.claude-code-nvim;
    };

    mkNvim = pkgs: runtimePkgs:
      inputs.wrappers.wrappers.neovim.wrap {
        inherit pkgs runtimePkgs;
        env."NVIM_APPNAME" = "nvim-nix";
        settings.config_directory = ./.;
        # Read in lua/config/lazy.lua via require("nix-info"): points lazy.nvim
        # at the store instead of letting it clone/update plugins itself.
        info.lazy.plugins = pkgs.linkFarm "lazy-plugins" (lazyPlugins pkgs);
      };
  in {
    packages = forAllSystems (pkgs: {
      default = mkNvim pkgs (with pkgs; [
        # LSPs / formatters
        lua-language-server
        vscode-langservers-extracted
        rust-analyzer
        ast-grep
        prettier
        black
        alejandra
        rustfmt
        python313Packages.python-lsp-server
        stylua
        nixd

        # other tools
        tree-sitter
        ripgrep
        gcc
        cargo
        fzf
        gnumake
        imagemagick
      ]);

      minimal = mkNvim pkgs (with pkgs; [
        ripgrep
        fzf
      ]);
    });
  };
}
