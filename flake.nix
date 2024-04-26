{
  description = "microzig development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-23.11";
    flake-utils.url = "github:numtide/flake-utils";

    # required for latest zig
    zig.url = "github:mitchellh/zig-overlay";

    zls.url = "github:zigtools/zls";


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
        # Other overlays
        (final: prev: {
          zigpkgs = inputs.zig.packages.${prev.system};
          zls = inputs.zls.packages.${prev.system}.zls;
        })
      ];

      # Our supported systems are the same supported systems as the Zig binaries
      systems = builtins.attrNames inputs.zig.packages;


      # buildenv-python-pkgs = ps: with ps; [
      #   # ...
      #   (
      #     # https://files.pythonhosted.org/packages/26/b4/bd652fbd5cbfa4f149e1630c0da70dc3c37ac27187eb8425eb403bd28a88/dataclasses_json-0.6.3.tar.gz
      #     buildPythonPackage rec {
      #       pname = "dataclasses_json";
      #       version = "0.6.3";
      #       pyproject = true;
      #       src = fetchPypi {
      #         inherit pname version;
      #         sha256 = "sha256-NctAqugkc2/flZgBNWZBg2NlIZz+FMrrEVw5E293XSo=";
      #       };
      #       doCheck = false;
      #       propagatedBuildInputs = [
      #         # Specify dependencies
      #         ps.poetry-dynamic-versioning
      #         pkgs.poetry
      #         ps.poetry-core
      #       ];
      #     }
      #   )
      # ];

    in
    flake-utils.lib.eachSystem systems (
      system:
      let
        pkgs = import nixpkgs { inherit overlays system; };
      in
      let

        python3 = pkgs.python3.override {
          self = python3;
          packageOverrides = self: super: {
            dataclasses_json = self.buildPythonPackage rec {
              pname = "dataclasses_json";
              format = "pyproject";
              version = "0.6.3";
              src = self.fetchPypi {
                inherit pname version;
                sha256 = "sha256-NctAqugkc2/flZgBNWZBg2NlIZz+FMrrEVw5E293XSo=";
              };
              doCheck = false;
              nativeBuildInputs = [ self.poetry-dynamic-versioning self.poetry-core ];
            };
          };
        };
      in
      rec {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [
            pkgs.zigpkgs."0.12.0"
            pkgs.zls
            (python3.withPackages (ps: [
              ps.dataclasses_json
              ps.marshmallow
              ps.typing-inspect
              ps.semver
              ps.pathspec
            ]))
          ];

          buildInputs = [
            # we need a version of bash capable of being interactive
            # as opposed to a bash just used for building this flake
            # in non-interactive mode
            pkgs.bashInteractive
            pkgs.zlib
          ];

          shellHook = ''
            # once we set SHELL to point to the interactive bash, neovim will
            # launch the correct $SHELL in its :terminal
            export SHELL=${pkgs.bashInteractive}/bin/bash
          '';
        };

        # For compatibility with older versions of the `nix` binary
        devShell = self.devShells.${system}.default;
      }
    );
}
