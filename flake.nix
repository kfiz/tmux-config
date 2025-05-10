{
  description = "Doro's home-manager tmux config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    with inputs;
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "aarch64-darwin"
        "x86_64-linux"
        "x86_64-linux"
      ];
      imports = [
        inputs.home-manager.flakeModules.home-manager
        inputs.treefmt-nix.flakeModule
      ];
      flake = {
        homeModules.default = { pkgs, ... }: import ./default.nix { inherit pkgs inputs; };
      };
      perSystem = {
        treefmt.programs.nixfmt.enable = true;
      };
    };
}
