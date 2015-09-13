#!/bin/sh

SCRIPT_DIR=$(cd $(dirname "$0") && pwd)
OLD_DIR=$(pwd)

install_plugin() {
    PLUGIN_URL=$1
    PLUGIN_NAME=$2
    if [ ! -d ${PLUGIN_NAME} ]; then
        echo "Downloading ${PLUGIN_URL} to ${PLUGIN_NAME}"
        git clone "$PLUGIN_URL" "$PLUGIN_NAME"
    fi
}

add_to_vimrc() {
    ADD_FILE_NAME=$1
    grep --quiet "$(cat $ADD_FILE_NAME)" ~/.vimrc > /dev/null
    if [ $? -ne 0 ]; then
        echo "Adding ${ADD_FILE_NAME} to vimrc..."
        cat ${ADD_FILE_NAME} >> ~/.vimrc
    fi
}

cd $SCRIPT_DIR

echo 'Installing vim and gvim...'
sudo apt-get install vim vim-gtk

install_plugin https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

add_to_vimrc vundle.vimrc
add_to_vimrc whitespace.vimrc

echo 'Installing Vundle plugin...'
vim +PluginInstall +qall

cd $OLD_DIR
