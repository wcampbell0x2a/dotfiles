# Start X at login
if status is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx -- -keeptty
    end
end

# set nvim as EDITOR
set -Ux EDITOR nvim

# Use grep color always
set -g GREP_OPTIONS '--color=always'

# Set dircolors
eval ( dircolors --c-shell $HOME/.dircolors.256dark )

# Fix gpg key request in git
export GPG_TTY=(tty)

# Needed for java fix
wmname LG3D

starship init fish | source
