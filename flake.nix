{
  description = "kat flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    niri.url = "github:sodiboo/niri-flake";
    home-manager.url = "github:nix-community/home-manager";
    catppuccin.url = "github:catppuccin/nix";
    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    std.url = "github:icebox-nix/std";
    netkit.url = "github:icebox-nix/netkit.nix";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    niri,
    home-manager,
    catppuccin,
    millennium,
    zen-browser,
    noctalia,
    std,
    netkit,
  } @inputs:

  {
#--------------
# - Think Pad -
# -------------
    nixosConfigurations."kat-t480s" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };

      modules = [
          home-manager.nixosModules.home-manager
          ./default.nix
          ./hosts/t480s/configuration.nix
          std.nixosModule
          netkit.nixosModule
          {
            nixpkgs.overlays = [ 
              inputs.millennium.overlays.default

              (final: prev: {
                pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
                  (python-final: python-prev: {
                    ConfigArgParse = python-final.configargparse;
                  })
                ];
              })
            ];
            nixpkgs.config.permittedInsecurePackages = [
              "electron-39.8.10"
            ];
          }
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.kat5 = {
              imports = [
                ./home/kat5.nix
              ];
            };
          }
        ];
      };
#------------------
# - Server Config -
# -----------------
    nixosConfigurations."generic-server" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };

      modules = [
          ./default.nix
          ./hosts/server/configuration.nix
          {
            nixpkgs.overlays = [ inputs.millennium.overlays.default ];
            nixpkgs.config.permittedInsecurePackages = [
              "electron-39.8.10"
            ];
          }
        ];
    };


  };

}