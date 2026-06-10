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

        typstNvimBin = pkgs.symlinkJoin {
          name = "typst-nvim";
          paths = [ neovimWithPlugins ];
          nativeBuildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            makeWrapper ${neovimWithPlugins}/bin/nvim $out/bin/typst-nvim \
              --set NVIM_APPNAME nvim \
              --set XDG_CONFIG_HOME "${self}"
              --set VIMINIT "lua dofile('${self}/nvim/init.lua')"
          '';
        };

        in {
            packages.${system} = {
                default = typstNvimBin;
                typst-nvim = typstNvimBin;
            };
            devShells.${system}.default = pkgs.mkShell {
            name = "typst-nvim";

            packages = [
                typstNvimBin
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
