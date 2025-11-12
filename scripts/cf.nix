{ pkgs }:

(pkgs.writeShellApplication {
  name = "cf";
  text = ''
    ts=$(date +%s)
    path=$"/tmp/$ts"

    mkdir -p "$path"
    cp --no-preserve=mode ${./../cf.cpp} "$path/cf.cpp"
    ln -sf "$path/cf.cpp" /tmp/latest.cpp

    ${pkgs.runtimeShell} -c "cd $path && $EDITOR cf.cpp"
  '';
})
