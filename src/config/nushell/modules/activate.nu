export def main [cmd: string, activate_cmd: closure] {
    let activate_path = $nu.data-dir | path join "vendor/autoload" | path join $"($cmd).nu"

    if (which ^($cmd) | is-empty) {
        rm --force -- $activate_path
        return
    }

    do $activate_cmd | save --force -- $activate_path
}
