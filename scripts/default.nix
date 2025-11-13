{ pkgs, ... }:

let
  load = p: import p { inherit pkgs; };
in

(builtins.map load [
  ./cf.nix
  ./qs.nix
  ./mknote.nix
  ./getfavicon
])
