
# My dotfiles


**Note**
Here is the structure of my "dot files" in my home directory. At the moment we have theses:

- tmux.conf
- zshrc

## Bash Dedicated guide

Because `.bashrc` i have diferent linux distros is going to be to hard to manage bashrc for ubunto and for fedora etc.
So i think fragments the bash (common) aliases.sh, environment.sh, and prompts.sh can be good choice.

1. **Create directoy config bash**:
```sh
mkdir -p ~/.config/bash
```
2. **Create bash files**:
```sh
touch ~/.config/bash/{aliases.sh,functions.sh,env.sh,history.sh}
```

I'm going to create a bash script called  `sourcing_bashrc.sh`  in `$HOME/.dotfiles_auxi/` with this:    
```bash
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
```
