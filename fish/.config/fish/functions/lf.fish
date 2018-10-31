# list custom functions
function lf --description "list fish custom functions"
    echo "Use type 'function' to display function information"
    ls ~/.config/fish/functions/ | sed -e 's/\.[^.]*$//'
end
