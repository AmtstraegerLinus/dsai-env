{
  description = "A Nix-flake-based python development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      # system should match the system you are running on
      system = "x86_64-linux";
    in
    {
      devShells."${system}".default =
        let
          pkgs = import nixpkgs { inherit system; };
        in
        pkgs.mkShell {
          # create an environment with python and it's packages pyusb, pillow, hidapi
          packages = with pkgs; [
            (pkgs.python3.withPackages (
              python-pkgs: with python-pkgs; [
                # select Python packages here
                pyusb
                pillow
                hidapi
              ]
            ))

          ];

          shellHook = ''
            echo "python `python --version`"
          '';
        };
    };
}
