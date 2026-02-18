{
  description = "kat flake";


  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    niri.url = "github:sodiboo/niri-flake";

    home-manager.url = "github:nix-community/home-manager";

    catppuccin.url = "github:catppuccin/nix";

    affinity-nix.url = "github:mrshmllow/affinity-nix";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { 
    self, 
    nixpkgs, 
    niri, 
    home-manager, 
    catppuccin, 
    affinity-nix,

    ...

    } @inputs: 
    
    
    
    {
    nixosConfigurations."kat-t480s" = nixpkgs.lib.nixosSystem {

      specialArgs = { inherit inputs; };

        modules = [
          ./default.nix
          niri.nixosModules.niri
          home-manager.nixosModules.home-manager 

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.cat5 = {
              imports = [
                ./home/cat5.nix
            ];
          };
        }
      ];
    };
  }; 
}
