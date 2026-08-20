#!/usr/bin/env bash

BASHRC="$HOME/.bashrc"
MARKER="# Custom modular bash config"

# Only append if not already added
if ! grep -qF "$MARKER" "$BASHRC"; then
    cat << 'EOF' >> "$BASHRC"

# Custom modular bash config
. "$HOME/.config/bash/env.sh"
. "$HOME/.config/bash/aliases.sh"
. "$HOME/.config/bash/functions.sh"
. "$HOME/.config/bash/history.sh"
EOF
    echo "Configurations added to $BASHRC successfully."
else
    echo "Configurations already exist in $BASHRC. Skipping."
fi

