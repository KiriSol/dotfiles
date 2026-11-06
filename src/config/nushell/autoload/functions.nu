### Functions with external commands

def --env y [...args] {
    if (which ^yazi | is-empty) {
        return
    }

    let tmp = (mktemp -t "yazi-cwd.XXXXXX")
    ^yazi --cwd-file $tmp ...$args
    let cwd = (open $tmp)
    if $cwd != $env.PWD and ($cwd | path exists) {
        cd -- $cwd
    }
    rm -fp $tmp
}
