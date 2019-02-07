function gitbragdiff --description "Gitbrag but with diff enter the sha in the parameter"
    function print_usage
        echo 'Show git authors between two commit shas.'
        echo
        echo 'Usage: gitbragdiff <START> <END>'
    end

    test (count $argv) = 0
    or [ $argv[1] = "-h" ]
    or [ $argv[1] = "--help" ]
    and print_usage; and return 0

        git log $argv[1]...$argv[2] --numstat --pretty="%ae %H" | grep -v -E '*\.(ui)$' | sed 's/@.*//g' | awk '{ if (NF == 1){ name = $1}; if(NF == 3) {plus[name] += $1; minus[name] += $2}} END { for (name in plus) {print name": +"plus[name]" -"minus[name]}}' | sort -k2 -gr
end

