if status is-interactive
    # Zoxide
    if type -q zoxide
        zoxide init fish | source
    end

    # Fzf
    if type -q fzf
        fzf --fish | source
    end

    # Starship prompt
    if type -q starship
        # function starship_transient_prompt_func
        #     starship module character
        # end
        starship init fish | source
        # enable_transience
    end
end
