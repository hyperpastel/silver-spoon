{ pkgs }:
let 
    template = "@local/flow";
in
(pkgs.writeShellApplication {
  name = "mknote";
  text = ''
    function join_by { 
        local IFS="$1";
        shift;

        local skip_last="$1"
        shift;

        local values=()

        if [ "$skip_last" = true ]; then
            local len=$#
            values=( "''${@:1:len-1}")
        else
            values=("$@")
        fi

        echo "''${values[*]}"; 
    }

    template="${template}"

    parent_path=$(join_by / true "$@")
    main_path=$(join_by / false "$@")

    mkdir -p "$parent_path"

    echo "$parent_path"
    echo "$main_path"

    if [ ! -d "$main_path" ]; then
        typst init "$template" "$main_path"
    fi

    $EDITOR "$main_path/main.typ"

  '';
})
