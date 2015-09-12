#!/bin/sh
SCRIPT_DIR=$(cd $(dirname "$0") && pwd)
BASHRC_FILE=~/.bashrc

ORIGINAL_DIR=$(pwd)
cd "$SCRIPT_DIR"

# Install curl
which curl > /dev/null
if [ $? -ne 0 ]; then
    echo 'Installing curl...'
    sudo apt-get install curl
fi

# Download the pyenv installer and install pyenv
which pyenv > /dev/null
if [ $? -ne 0 ]; then
    echo 'Installing pyenv...'
    PYENV_INSTALLER_URL='https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer'
    curl -L "$PYENV_INSTALLER_URL" | bash
fi

# Add pyenv
PYENV_INIT_FILE='init_pyenv.inc'
grep --quiet "$(cat $PYENV_INIT_FILE)" ~/.bashrc > /dev/null
if [ $? -ne 0 ]; then
    echo 'Adding pyenv support to .bashrc...'
    cat "$PYENV_INIT_FILE" >> "$BASHRC_FILE"
fi

# Install necessary libraries for building Python

# Assumes debian
echo 'Installing libraries for building Python...'
LIBRARIES_TO_INSTALL='libbz2-dev libsqlite3-dev libreadline-dev zlib1g-dev libncurses5-dev libssl-dev libgdbm-dev'
sudo apt-get install $LIBRARIES_TO_INSTALL

# Activate pyenv environment
. "./$PYENV_INIT_FILE"

# Install useful pythons
echo 'Installing pythons...'
pyenv install -s 2.7.10
pyenv install -s 3.4.3
pyenv install -s miniconda-3.16.0
pyenv install -s miniconda3-3.16.0
pyenv install -s pypy-2.6.1

cd "$ORIGINAL_DIR"
