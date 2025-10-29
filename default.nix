{
  nixpkgs,
  # hyprland,
  ...
}@inputs:
let
  systems = [
    "x86_64-linux"
  ];
  forAllSystems = nixpkgs.lib.genAttrs systems;
  forEachSupportedSystem =
    f:
    inputs.nixpkgs.lib.genAttrs systems (
      system:
      f {
        pkgs = import inputs.nixpkgs { inherit system; };
      }
    );
  host = builtins.attrNames (builtins.readDir ./hosts);
  desktop = builtins.attrNames (builtins.readDir ./desktops);
  theme = builtins.attrNames (builtins.readDir ./themes);
  cfgs = nixpkgs.lib.attrsets.cartesianProduct { inherit host desktop theme; };
in
{
  formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

  nixosConfigurations = builtins.listToAttrs (
    map (cfg: {
      name = "${cfg.host}_${cfg.desktop}_${cfg.theme}";
      value = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs cfg;
        };
        modules = [
          ./hosts/${cfg.host}
        ];
      };
    }) cfgs
  );
  devShells = forEachSupportedSystem (
    { pkgs }:
    {
      default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          nil
          nixd
          niv
        ];
      };
    }
  );
}
