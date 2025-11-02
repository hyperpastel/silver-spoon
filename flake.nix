{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      scripts = [
        (pkgs.writeShellApplication {
          name = "qs";
          runtimeInputs = with pkgs; [
            nix
          ];
          text = (builtins.readFile ./scripts/qs);
        })

        (pkgs.writeShellApplication {
          name = "cf";
          text = ''
            ts=$(date +%s)
            path=$"/tmp/$ts"

            mkdir -p "$path"
            cp --no-preserve=mode ${./cf.cpp} "$path/cf.cpp"
            ln -sf "$path/cf.cpp" /tmp/latest.cpp

            ${pkgs.runtimeShell} -c "cd $path && $EDITOR cf.cpp"
          '';
        })

        (pkgs.writeShellApplication {
          name = "mkdaily";
          text = ''
            name="$(date +%Y-%m-%d)"
            if [[ ! -e $name ]]; then
                typst init @local/flow "$name"

                sed -i -e s/preview/local/ ./"$name"/main.typ

                if [[ $# -gt 0 ]]; then
                    sed -i -e s/"Super cool title!"/"$1"/ ./"$name"/main.typ
                fi
            fi

            cd "$name" && $EDITOR main.typ
          '';
        })
      ];
    in
    {

      inherit scripts;

      devShells = {
        ${system}.default = pkgs.mkShell {
          packages = scripts;
        };
      };
    };
}
