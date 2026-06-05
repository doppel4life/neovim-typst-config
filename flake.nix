{
  description = "neovim config for typst document editing";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
        let 
            system = "x86_64-linux";
            pkgs = import nixpkgs {inherit system;};

        neovimWithPlugins = pkgs.neovim.override {
            configure = {
                packages.nix = {
                    start = with pkgs.vimPlugins; [
                        (nvim-treesitter.withPlugins (p: [
                            p.typst p.lua p.vim p.vimdoc
                        ]))
                        nvim-lspconfig
                        lualine-nvim
                    ];
                };
            };
        };

        in {
            packages.${system} = {
                default = neovimWithPlugins;
                typst-nvim = neovimWithPlugins;
            };
            devShells.${system}.default = pkgs.mkShell {
            name = "typst-nvim";

            packages = [
                neovimWithPlugins
                pkgs.typst
                pkgs.tinymist
                pkgs.harper
                pkgs.ltex-ls
                pkgs.git
            ];

            shellHook =''
                export XDG_CONFIG_HOME="$(pwd)"
                export NVIM_APPNAME="nvim"
                export VIMINIT="source $(pwd)/nvim/init.lua"
                echo "Hello vim"
                '';
        };
    }; 
}
