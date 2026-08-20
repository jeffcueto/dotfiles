
# Bash Dedicated guide

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

3. **To evoid to write** the sources to those files above form my bashrc. I'm going to create a bash script called  `sourcing_bashrc.sh`  in `$HOME/.dotfiles_auxi/` with this:    
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
4. **Execute the bash script**: To do that you can just copy the content above and execute. or usr the curl like this:
```bash
# for link codeberg
curl -L https://codeberg.org/jeffcueto/dotfiles/raw/branch/main/.dotfiles_auxi/sourcing_bashrc.sh | bash
# for url github just change the link
```
