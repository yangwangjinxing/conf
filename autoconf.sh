#!/bin/bash
sudo apt install vim 
sudo apt install build-essential cmake
sudo apt install python-dev python3-dev 
mkdir ~/.vim >/dev/null
mkdir ~/.vim/bundle >/dev/null
mkdir ~/.vim/bundle/YouCompleteMe
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle.vim
cp .vimrc ~
cp .zshrc ~
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh
chmod +x install.sh
./install.sh > /dev/null
rm install.sh
#wget "https://github.com/Valloric/YouCompleteMe/archive/master.zip"
#unzip master.zip
#rm master.zip
#mv YouCompleteMe-master YouCompleteMe
#mv YouCompleteMe ~/.vim/bundle/
cd ~/.vim/bundle/
git "https://github.com/Valloric/YouCompleteMe.git"
cd YouCompleteMe
git submodule update --init --recursive
cp -r .ycm_extra_conf.py ~/.vim/bundle/YouCompleteMe/
cd ~/.vim/bundle/YouCompleteMe
python ./install.py --clang-completer
vim -c PluginInstall
source ~/.zshrc

