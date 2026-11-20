### Config

use modules/activate.nu

$env.config.history.path = $nu.data-dir | path join history.txt
$env.config.show_banner = false

if $nu.is-interactive {
    activate zoxide { ^zoxide init nushell }
    activate fzf { ^fzf --nushell }

    # Prompt
    if (which ^starship | is-not-empty) {
        $env.TRANSIENT_PROMPT_COMMAND = { ^starship module character }
    }
    activate starship { ^starship init nu }
}
