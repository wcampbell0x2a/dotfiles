# Search git repo for file and branch status and print to terminal
function gitshow --description "show recursive git status"
    find . -maxdepth 1 -mindepth 1 -type d -exec sh -c '(echo {} && cd {} && git status -sb && echo)' \;
end
