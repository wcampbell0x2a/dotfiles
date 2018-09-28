# list custom functions
function lf --description "list fish custom functions"
    ls ~/.config/fish/functions/ | sed -e 's/\.[^.]*$//'
end
