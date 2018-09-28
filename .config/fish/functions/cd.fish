# Automatic ls after cd
function cd --description "auto ls for each cd"
  if [ -n $argv[1] ]
    builtin cd $argv[1]
    and ls -laAF
  else
    builtin cd ~
    and ls -laAF
  end
end
