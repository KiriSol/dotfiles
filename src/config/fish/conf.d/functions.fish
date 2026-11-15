### Functions with external commands

if type -q yazi
    function y
        set -l tmp (mktemp -t "yazi-cwd.XXXXXX")
        command yazi --cwd-file "$tmp" $argv
        if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
            builtin cd -- "$cwd"
        end
        command rm -f "$tmp"
    end
end
