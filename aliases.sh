# Create a directory and cd into it
mcd() {
    mkdir "${1}" && cd "${1}"
}

# Execute a command in a specific directory
xin() {
    ( cd "${1}" && shift && (eval "${@}") )
}

# Quick Python3
alias py=python3

# Quick IPython shell
alias ipy=ipython

# Use colors in coreutils utilities output
alias tree='tree -a -C -l -q -I ".git"'

# Quick zathura
alias z=zathura

# Quick clone one of my repos
my () {
    git clone --recurse-submodules https://github.com/danielfalbo/$1
}

# quick clear
alias c=clear
