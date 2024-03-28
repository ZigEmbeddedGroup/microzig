{
  description = "microzig website environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-23.11";
    flake-utils.url = "github:numtide/flake-utils";

    # required for latest zig
    zig.url = "github:mitchellh/zig-overlay";

    # Used for shell.nix
    flake-compat = {
      url = github:edolstra/flake-compat;
      flake = false;
    };
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , ...
    } @ inputs:
    let
      overlays = [
        (final: prev: { zigpkgs = inputs.zig.packages.${prev.system}; })
      ];

      # Our supported systems are the same supported systems as the Zig binaries
      systems = builtins.attrNames inputs.zig.packages;
    in
    flake-utils.lib.eachSystem systems (
      system:
      let
        pkgs = import nixpkgs { inherit overlays system; };
      in
      rec {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [ pkgs.zigpkgs.master ];

          buildInputs = [ pkgs.bashInteractive ];

          shellHook = ''
            export SHELL=${pkgs.bashInteractive}/bin/bash
          '';
        };

        # For compatibility with older versions of the `nix` binary
        devShell = self.devShells.${system}.default;
      }
    );
}
