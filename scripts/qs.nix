{ pkgs }:

(pkgs.writeShellApplication {
  name = "qs";
  runtimeInputs = with pkgs; [
    nix
  ];
  text = ''
    set -euo pipefail

    if [[ $# -lt 1 ]]; then
        echo "Missing packages"
    else 
        array=("$@")
        nix shell "''${array[@]/#/p\#}"
    fi

  '';
})
