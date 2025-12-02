# /bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${BASEDIR}"

/bin/rm -f ~/.tmux.conf
ln -sf "${BASEDIR}/tmux.conf" ~/.tmux.conf

/bin/rm -f ~/.alacritty.toml
ln -sf "${BASEDIR}/alacritty.toml" ~/.alacritty.toml

mkdir -p ~/Library/Application\ Support/com.mitchellh.ghostty/
/bin/rm -f ~/Library/Application\ Support/com.mitchellh.ghostty/config
ln -sf "${BASEDIR}/ghostty" ~/Library/Application\ Support/com.mitchellh.ghostty/config

mkdir -p ~/.config/fish/conf.d/
/bin/rm -f ~/.config/fish/conf.d/login.fish
ln -sf "${BASEDIR}/login.fish" ~/.config/fish/conf.d/login.fish
