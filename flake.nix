{
  description = "Doro's home-manager tmux config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    home-manager = {
      url = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tmux-powerkit.url = "github:fabioluciano/tmux-powerkit";
  };

  outputs =
    inputs:
    with inputs;
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import systems;
      imports = [
        inputs.home-manager.flakeModules.home-manager
        inputs.treefmt-nix.flakeModule
      ];
      flake = {
        homeModules.default = import ./default.nix inputs;
      };
      perSystem = {
        treefmt.programs.nixfmt.enable = true;
      };
    };
}
