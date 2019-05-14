# Start X at login
if status is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx -- -keeptty
    end
end

# Use grep color always
set -g GREP_OPTIONS '--color=always'

# Set dircolors
eval ( dircolors --c-shell $HOME/.dircolors.ansi-dark )

# Fix gpg key request in git
export GPG_TTY=(tty)
