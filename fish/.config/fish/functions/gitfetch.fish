# execute git fetch in all recursive folders
function gitfetch --description "recursive fetch all folders"
    find . -maxdepth 1 -mindepth 1 -type d -exec sh -c '(echo {} && cd {} && git fetch --all --prune && echo)' \;
end
