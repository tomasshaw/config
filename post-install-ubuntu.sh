#!/bin/bash

read -rep "Warning: This will force and wipe everything. Please don't run if you're not sure what you're doing. This is intended for fresh ubuntu installs. Continue? [y/N] " areyousure
if [[ "$response" =~ [yY] ]]
then
	echo " Beginning instalation process "
else
	echo " Cancelling instalation process "
	exit
fi

read -rep "Would you like to install X server? [y/N] " response

# Update packages
echo " Updating packages "
sudo apt update; sudo apt upgrade -y

# Install from apt
echo " Installing packages "
sudo apt install -y \
	gh \
	fzf \
	nvm \
	zsh \
	exa \
	neovim \
	thefuck \

# Install X server
echo " Installing X packages "
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
sudo apt install -y \
	libgtk2.0-0 \
	libgtk-3-0 \
	libgbm-dev \
	libnotify-dev \
	libgconf-2-4 \
	libnss3 \
	libxss1 \
	libasound2 \
	libxtst6 \
	xauth \
	xvfb
fi

# Oh-my-ZSH 
echo " Installing & configuring 'Oh-my-ZSH' "
sh -c '$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)'
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Oh-my-TMUX
cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf

# Create source code folder structure
mkdir source
cd source
git clone https://github.com/tomasshaw/config.git

# Create symlinks
cd
ln -s ~/source/config/.p10k.zsh
ln -s ~/source/config/.tmux.conf.local
ln -s ~/source/config/.zshrc

# Create ssh config folder & symlinks
mkdir -p ~/.ssh
cd ~/.ssh
ln -s ~/source/config/ssh/config
ln -s ~/source/config/ssh/authorized_keys

# Create nvim config folder & symlinks
mkdir -p ~/.config/nvim
cd ~/.config/nvim
ln -s ~/source/config/nvim

# Configure node & npm
nvm install --lts
npm i -g neovim commitizen cz-conventional-changelog eslint prettier

# Change user shell to zsh
sudo chsh -s /bin/zsh $USER

# Install Vim Plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Git config
git config --global user.email "tomasshaw@outlook.com"
git config --global user.name "Thomas A. Shaw"

# Reboot
sudo reboot now
