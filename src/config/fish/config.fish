### Config

if status is-interactive
    type -q zoxide; and zoxide init fish | source
    type -q fzf; and fzf --fish | source

    # Prompt
    if type -q starship
        function starship_transient_prompt_func
            starship module character
        end
        starship init fish | source
        enable_transience
    end
end
