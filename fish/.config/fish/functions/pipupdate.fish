# Automatic pip list update
function pipupdate --description "automatic pip list update"
  pip list --outdated | sed -n '1,2!p' | awk '{system("pip install "$1" --upgrade --user")}'
end
