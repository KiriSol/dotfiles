### Functions with external commands

if type -q yazi
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        command yazi --cwd-file="$tmp" $argv
        if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
            builtin cd -- "$cwd"
        end
        command rm -f -- "$tmp"
    end
end

if type -q eza
    function lt
        set -l level $argv[1]
        if test -z $level
            set level 1
        end
        tree --level $level $argv[2..-1]
    end
end
