# Clean git branches that aren't merged to current/dev/master
function gitcleancurrent --description "clean current branches"
    git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
end
