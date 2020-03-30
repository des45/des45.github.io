type git > /dev/null || exec echo "missing dependences: git not found"

[ -f $HOME/.gitignore ] || echo ".dotfiles.git" >> \
	$HOME/.gitignore && echo "gitignore created" 

[ -d $HOME/.dotfiles.git ] || \
git clone --bare "https://github.com/des45/dotfiles.git" $HOME/.dotfiles.git

dotfiles="git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME"

$dotfiles checkout > /dev/null || exec echo "checkout failed"

$dotfiles config --local status.showUntrackedFiles no

[ $SHELL = $(which zsh) ] && source $HOME/.zsh

echo "dotfiles was successfully imported"
