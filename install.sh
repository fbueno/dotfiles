#!/bin/bash -e

REPO_URL="https://github.com/fbueno/dotfiles.git"
ARCHIVE_URL="https://github.com/fbueno/dotfiles/archive/master.zip"
DIR_NAME=".dotfiles"
DOWNLOAD_CMDS="wget curl lynx"
FILES_LIST="xbindkeysrc bash_prompt.sh bashrc gitconfig vim"
EXTRA_FILE_COMMANDS=".vim/vimrc:.vimrc"
PACKAGES="git python-pip"
PIP_PACKAGES="jedi"
DIRS=".vimfiles"


function install_packages 
{
    if [ -x /usr/bin/apt-get ]; then
       sudo apt-get -y install $PACKAGES
   else
       yum -y install $PACKAGES
       #yum -y install `echo $PACKAGES | sed -e 's/python-pip//g'`
       $cmd_path http://peak.telecommunity.com/dist/ez_setup.py
       python ez_setup.py 
       easy_install pip
   fi
   pip install $PIP_PACKAGES
}


function git_clone 
{
    git clone "$REPO_URL" $DIR_NAME
}

function set_download_command 
{
    for cmd in $DOWNLOAD_CMDS
    do
        cmd_path=$(which $cmd)
        if [ -x $cmd_path ]; then
            DOWNLOAD_COMMAND=$cmd_path
            break
        fi
        echo "Cannot find any download command"
        echo "install one of these: $DOWNLOAD_CMDS"
        exit 1
    done
}


function download_files 
{
    $cmd_path $ARCHIVE_URL    
    unzip master.zip
    mv dotfiles-master .dotfiles
    \rm -f master.zip
}

function link_files 
{
    for dot_file in $FILES_LIST
    do
        src=$(echo $dot_file | cut -d: -f1)
        dst=$(echo $dot_file | cut -d: -f2)
        if [ "$dst" = "$src" ]; then
            dst=.$dst
        fi
        ln -snf $HOME/$DIR_NAME/$src $HOME/$dst
    done
    for extra_dot_file in $EXTRA_FILE_COMMANDS
    do
        src=$(echo $extra_dot_file | cut -d: -f1)
        dst=$(echo $extra_dot_file | cut -d: -f2)
        if [ "$dst" = "$src" ]; then
            dst=.$dst
        fi
        ln -snf $HOME/$src $HOME/$dst
    done
}


function make_dirs 
{
    for d in $DIRS
    do
        mkdir -p ~/$d
    done
}

#function install_keys {

#pass

#}

cd $HOME
set_download_command
install_packages
if [ -d $DIR_NAME ]; then
    rm -rf $DIR_NAME
fi

#if [ -x $GIT ]; then
git_clone
#else
#    download_files
#fi

link_files

source ~/.bashrc

