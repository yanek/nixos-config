{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    hm.url = "github:nix-community/home-manager/master";
    hm.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    betterfox.url = "github:heitoraugustoln/betterfox-nix";
    betterfox.inputs.nixpkgs.follows = "nixpkgs";

    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";

    ags.url = "github:aylur/ags";
    ags.inputs.nixpkgs.follows = "nixpkgs";

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-stable,
    hm,
    ...
  } @ inputs: let
    systemSettings = {
      system = "x86_64-linux";
      timezone = "Europe/Paris";
      locale = "en_US.UTF-8";
      bootMode = "uefi";
      bootMountPath = "/boot";
    };

    userSettings = {
      username = "nk";
      fullname = "Noé Ksiazek";
      email = "noe.ksiazek@pm.me";
      theme = "nord";
      dirs = {
        home = "/home/${userSettings.username}";
        config = "${userSettings.dirs.home}/.nixos-config";
        theme = "${userSettings.dirs.config}/modules/themes/${userSettings.theme}";
      };
    };

    pkgs-stable = import nixpkgs-stable {
      system = systemSettings.system;
      config = {
        allowUnfree = true;
      };
    };

    pkgs = import nixpkgs {
      system = systemSettings.system;
      config = {
        allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      nkdtop = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        system = systemSettings.system;
        specialArgs = {
          inherit inputs;
          inherit pkgs-stable;
          inherit systemSettings;
          inherit userSettings;
        };
        modules = [
          ./hosts/nkdtop/configuration.nix
        ];
      };
      nkltop = nixpkgs.lib.nixosSystem {
        system = systemSettings.system;
        specialArgs = {
          inherit inputs;
          inherit pkgs-stable;
          inherit systemSettings;
          inherit userSettings;
        };
        modules = [
          ./hosts/nkltop/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "nk@nkdtop" = hm.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs;
          inherit pkgs;
          inherit systemSettings;
          inherit userSettings;
        };
        modules = [
          ./users/nk.nix
          inputs.stylix.homeManagerModules.stylix
          inputs.nvf.homeManagerModules.default
          inputs.nixcord.homeModules.nixcord
        ];
      };

      "nk@nkltop" = hm.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs;
          inherit pkgs;
          inherit systemSettings;
          inherit userSettings;
        };
        modules = [
          ./users/nk.nkltop.nix
          inputs.stylix.homeManagerModules.stylix
          inputs.nvf.homeManagerModules.default
          inputs.nixcord.homeModules.nixcord
        ];
      };
    };

    devShells.${systemSettings.system}.default = pkgs.mkShell {
      packages = with pkgs; [
        go-task
        vscode-langservers-extracted
      ];
    };
  };
}
