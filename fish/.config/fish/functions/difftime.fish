# Show difftool for time interval
function difftime --description "show difftool for interval"
    git difftool (git rev-list -n1 --before=$argv[1] (git symbolic-ref --short -q HEAD))
end
