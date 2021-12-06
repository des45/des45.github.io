#!/usr/bin/sh
type apt-get > /dev/null && (
apt update; sudo apt-get upgrade
apt install --upgrade neovim vim git fish tmux python3 curl wget fontconfig-utils
)
type git > /dev/null || exec echo "missing dependences: git not found"

[ -d $HOME/.cfg ] || \
git clone --bare "https://github.com/ashuya/dotfiles" $HOME/.cfg

config="git --git-dir=$HOME/.cfg --work-tree=$HOME"

$config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} |
    xargs -I{} rm {} -rf
$config checkout

$config config --local status.showUntrackedFiles no

curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
omf install bobthefish
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir -p ~/.local/share/fonts
mkdir -p ~/.config/fontconfig/conf.d
mv PowerlineSymbols.otf ~/.local/share/fonts
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d


echo \
"everything set up \
Restart your shell"
