{
  description = "Neovim wrapped by nix, plugins managed by vim.pack";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    wrappers.url = "github:BirdeeHub/nix-wrapper-modules";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f (import nixpkgs {inherit system;}));

    mkNvim = pkgs: runtimePkgs:
      inputs.wrappers.wrappers.neovim.wrap {
        inherit pkgs runtimePkgs;
        env = {
          # lua/plugins/init.lua discovers plugin modules relative to this.
          "CONFIG_ROOT" = ./.;
          "NVIM_APPNAME" = "nvim-nix";
        };
        settings.config_directory = ./.;
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
        pyright
        stylua
        nixd
        clang-tools

        # other tools
        wl-clipboard # nvim's Wayland clipboard provider (wl-copy / wl-paste)
        tree-sitter
        ripgrep
        fd # telescope's file finder
        gcc
        cargo
        fzf
        gnumake
        imagemagick
      ]);

      minimal = mkNvim pkgs (with pkgs; [
        wl-clipboard
        ripgrep
        fzf
        gcc
        gnumake
        tree-sitter
      ]);
    });
  };
}
