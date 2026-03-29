if type -q eza
    function lt --description "Tree view with level"
        set -l level $argv[1]
        if test -z "$level"
            set level 1
        end
        tree --level $level $argv[2..-1]
    end
end
