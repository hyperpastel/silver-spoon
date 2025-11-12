{ pkgs }:

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
