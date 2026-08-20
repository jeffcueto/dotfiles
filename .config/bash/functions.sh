# Shell function to mkdir... && cd ... repeatedly.
mkcd () {
    mkdir -p "$1" && cd "$1"
}

# Directory-Specific Umask:
cd() {
    builtin cd "$@" || return

    case "$PWD" in
        $HOME/lab|$HOME/lab/*)
            umask 002
            ;;
        *)
            umask 022
            ;;
    esac
}


