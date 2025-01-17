#!/usr/bin/env sh
type apt-get > /dev/null && (
apt update; apt upgrade
apt install --upgrade neovim vim git fish tmux python3 curl wget fontconfig-utils tldr
)
type git > /dev/null || exec echo "missing dependences: git not found"

tldr --update

[ -d "$HOME"/.cfg ] || \
git clone --bare "https://github.com/ashuya/dotfiles" "$HOME"/.cfg

config="git --git-dir=$HOME/.cfg --work-tree=$HOME"

$config checkout 2>&1 | grep -E "\s+\." | awk '{print $1}' |
    xargs -I{} rm {} -rf
$config checkout

$config config --local status.showUntrackedFiles no

curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
omf install bobthefish
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir -p "$HOME"/.local/share/fonts
mkdir -p "$HOME"/.config/fontconfig/conf.d
mv PowerlineSymbols.otf "$HOME"/.local/share/fonts
mv 10-powerline-symbols.conf "$HOME"/.config/fontconfig/conf.d
fc-cache -vf "$HOME"/.local/share/fonts/


echo \
"everything set up \
Restart your shell"
