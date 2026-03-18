(
    cd root-aarch64
    #cd root-x86_64
    for i in $(tree -fi *); do
        [[ -f $i ]] && echo $i
    done
)

