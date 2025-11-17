{ pkgs, ... }:

let
  load = p: import p { inherit pkgs; };
in

(builtins.map load [
  ./cf
  ./qs.nix
  ./mknote.nix
  ./getfavicon
])
