{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    hm.url = "github:nix-community/home-manager/master";
    hm.inputs.nixpkgs.follows = "nixpkgs";

    # vault = {
    #   url = "git+ssh://git@github.com/yanek/vault.nix.git";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    stylix.url = "github:nix-community/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    betterfox.url = "github:heitoraugustoln/betterfox-nix";
    betterfox.inputs.nixpkgs.follows = "nixpkgs";

    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };

    spicetify = {
      url = "github:gerg-l/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      hm,
      ...
    }@inputs:
    let
      systemSettings = {
        system = "x86_64-linux";
        locale = "en_US.UTF-8";
        bootMode = "uefi";
        bootMountPath = "/boot";
      };

      userSettings = {
        username = "nk";
        fullname = "Noé Ksiazek";
        email = "noe.ksiazek@pm.me";
        dirs = {
          home = "/home/${userSettings.username}";
          config = "${userSettings.dirs.home}/.nixos-config";
        };
      };

      pkgs = import nixpkgs {
        inherit (systemSettings) system;
        config = {
          allowUnfree = true;
        };
        overlays = [
          # FIXME: for now, nightly neovim is broken on this config
          # inputs.neovim-overlay.overlays.default
          (import ./pkgs/scripts/overlay.nix)
          (import ./pkgs/by-name/overlay.nix)
        ];
      };
    in
    {
      nixosConfigurations =
        let
          mkCommonConfiguration =
            hostname:
            nixpkgs.lib.nixosSystem {
              inherit pkgs;
              inherit (systemSettings) system;
              specialArgs = {
                inherit inputs;
                inherit systemSettings;
                inherit userSettings;
              };
              modules = [
                ./hosts/${hostname}/configuration.nix
                inputs.stylix.nixosModules.stylix
              ];
            };
        in
        {
          nkdtop = mkCommonConfiguration "nkdtop";
          nkltop = mkCommonConfiguration "nkltop";
        };

      homeConfigurations =
        let
          mkCommonConfiguration =
            hostname:
            hm.lib.homeManagerConfiguration {
              inherit pkgs;
              extraSpecialArgs = {
                inherit inputs;
                inherit hostname;
                inherit systemSettings;
                inherit userSettings;
              };
              modules = [
                ./users/nk.nix
                inputs.stylix.homeModules.stylix
                inputs.spicetify.homeManagerModules.spicetify
                inputs.nvf.homeManagerModules.default
                inputs.nixcord.homeModules.nixcord
              ];
            };

        in
        {
          "nk@nkdtop" = mkCommonConfiguration "nkdtop";
          "nk@nkltop" = mkCommonConfiguration "nkltop";
        };

      devShells.${systemSettings.system}.default = pkgs.mkShell {
        packages = with pkgs; [
          go-task
          vscode-langservers-extracted
        ];
      };
    };
}
