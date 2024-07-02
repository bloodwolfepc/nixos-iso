{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/24.05";
    neovim = {
      url = "github:bloodwolfepc/dead";
    };
    nur = {
      url = "github:nix-community/NUR";
    };
  };
  outputs = { self, nixpkgs, nur, ... }@inputs: {
    nixosConfigurations = {
      default = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [ 
          ./configuration.nix
        ];
      };
      nixos-iso = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [ 
          ./configuration.nix
          
          #nur.nixosModules.nur
          
          #({ config, ... }: {
          #  environment.systemPackages = [ config.nur.repos.johnazoidberg.ssacli ];
          #})
          
          #This imports modules 
           
          #{ nixpkgs.overlays = [ nur.overlay ]; } #overlay for ssacli
          #({ pkgs, ... }:
          #  let
          #    nur-no-pkgs = import nur {
          #      nurpkgs = import nixpkgs { system = "x86_64-linux"; };
          #    };
          #  in {
          #    environment.systemPackages = [ nur-no-pkgs.repos.johnazoidberg.ssacli ];
          #  }
          #)
        ];
      };
    };
  };
}
