
function dirdiff -d "Compare reference dir path ($1) and current working directory on sub path ($2)"
    # Shell-escape each path:
    # $1 - reference dir base
    # $2 - sub. path from cwd
    set -l REF "$argv[1]"
    set -l SUB "$argv[2]"
    nvim $argv[3..-1] "+DirDiff $REF/$SUB $SUB"
end

