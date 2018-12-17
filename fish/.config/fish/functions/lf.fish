# list custom functions / scripts
function lf --description "list fish custom function / scripts"
    echo "--------------"
    echo "Fish Functions"
    echo "-Use >type 'function name' to display function information"
    echo "--------------"
    ls ~/.config/fish/functions/ | sed -e 's/\.[^.]*$//'
    echo
    echo "-------"
    echo "Scripts"
    echo "-------"
    ls ~/scripts
end
