# ~/.config/fish/conf.d/login.fish

function c; cursor-agent $argv; end
function lg; lazygit $argv; end
function v; nvim $argv; end
function goyo; vim -c 'set nocursorline' -c 'nmap ZQ :qa!<CR>' -c 'nmap ZZ :wqa<CR>' -c 'Goyo' $argv; end
function zen; nvim -c 'set nocursorline' -c 'nmap ZQ :qa!<CR>' -c 'nmap ZZ :wqa<CR>' -c 'Zen' $argv; end
function today; date -u +%Y-%m-%d; end
function l; ls -1 $argv; end
function t; tree -Ca -I .git $argv; end

set PATH $PATH ~/zig-aarch64-macos-0.16.0-dev.1399+7b325e08c/
export PATH
