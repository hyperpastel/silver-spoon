{ pkgs, ... }:

let
  p = pkgs.python3Packages;
in
(p.buildPythonApplication rec {
  pname = "getfavicon";
  version = "1.0";
  propagatedBuildInputs = with p; [
    beautifulsoup4
    requests
    lxml
  ];

  src = ./.;

  pyproject = false;
  dontUnpack = true;

  installPhase = ''
    install -Dm755 "${./${pname}}" "$out/bin/${pname}"
  '';
})
