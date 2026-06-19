{
  description = "kat flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    niri.url = "github:sodiboo/niri-flake";
    home-manager.url = "github:nix-community/home-manager";
    catppuccin.url = "github:catppuccin/nix";
    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    std = {
      url = "github:icebox-nix/std/86d9e8966205afdb940abf46f1f9cff6d03a3f5c";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    netkit = {
      url = "github:icebox-nix/netkit.nix/29f750af4fabee7b8eccb5ab00df7074b73c7658";
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
          inputs.std.nixosModule
          inputs.netkit.nixosModule
          {
            nixpkgs.overlays = [ inputs.millennium.overlays.default ];
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