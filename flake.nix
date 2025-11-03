{
  description = "Flat, Pastel, Cute Icons for Linux";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    icon_src = {
      flake = false;
      url = "github:IgorFerreiraMoraes/Mignon-icon-theme";
    };
  };

  outputs = {self, nixpkgs, ...}@inputs: let
    forAllSys = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.all;
  in {
    packages = forAllSys (system: let
      pkgs = import nixpkgs { inherit system; };
      mignon_pastel = pkgs.callPackage ./. {
        inherit (inputs) icon_src;
      };
      in {
        default = mignon_pastel;
      }
    );
  };
}