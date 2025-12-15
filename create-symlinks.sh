# /bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${BASEDIR}"

/bin/rm -f ~/.alacritty.toml
ln -sf "${BASEDIR}/alacritty.toml" ~/.alacritty.toml

mkdir -p ~/Library/Application\ Support/com.mitchellh.ghostty/
/bin/rm -f ~/Library/Application\ Support/com.mitchellh.ghostty/config
ln -sf "${BASEDIR}/ghostty" ~/Library/Application\ Support/com.mitchellh.ghostty/config

mkdir -p ~/.newsboat/
/bin/rm -f ~/.newsboat/urls
ln -sf "${BASEDIR}/urls" ~/.newsboat/urls
/bin/rm -f ~/.newsboat/config
ln -sf "${BASEDIR}/newsboat-config" ~/.newsboat/config
