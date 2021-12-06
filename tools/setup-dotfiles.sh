#!/usr/bin/sh
type apt-get > /dev/null && (
apt update; sudo apt-get upgrade
apt install --upgrade neovim vim git fish tmux python3 curl
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

echo \
"everything set up \
Restart your shell"
