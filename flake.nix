{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    systems.url = "github:nix-systems/default-linux";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, systems, ... }:
  let
    eachSystem = nixpkgs-stable.lib.genAttrs (import systems);
  in {
    packages = eachSystem (system:
  let
    # Меняем nixpkgs-stable на nixpkgs (это твоя unstable ветка)
    pkgs = import nixpkgs {
      system = "${system}";
    };
  in {
    default = self.packages.${system}.waterfox;
    waterfox = pkgs.callPackage ./pkgs/waterfox/default.nix {};
  });
  };
}
