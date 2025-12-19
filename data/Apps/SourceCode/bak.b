#!/bin/zsh

Main() {
    (
        cd ~

        git pull

        while true; do
            echo -n "[1] Status\n[2] Commit\n[3] Upload\n[c] Clear\n[x] exit\n>>> "
            read var
            case $var in
            "1") git status;;
            "2") git add . && git commit -m "$(TZ="Europe/Prague" date +"%d.%m.%Y-%Hh%Mm%Ss")";;
            "3") git push;;
            "c") clear;;
            "x") return;;
            esac
        done

        unset var
        return 0;
    )
}
Main;
