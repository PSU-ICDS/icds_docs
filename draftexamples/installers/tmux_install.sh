#!/bin/bash
# Script to install tmux
# Written by Emery Etter 20200212

BASE=$PWD
TMUX_VERSION=2.2

# GCC module is a dependency
module load gcc

# Download source file and requirement package
wget wget -O tmux-$TMUX_VERSION.tar.gz https://github.com/tmux/tmux/releases/download/$TMUX_VERSION/tmux-$TMUX_VERSION.tar.gz
wget https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz
wget https://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.1.tar.gz

# Unwrap downloaded files
tar -xzvf tmux-$TMUX_VERSION.tar.gz
tar -xzvf libevent-2.0.21-stable.tar.gz
tar -xzvf ncurses-6.1.tar.gz

# Set directory to place installation
BUILD_DIR=$BASE/tmux

# Install libevent2 from source
cd libevent-2.0.21-stable
./configure --prefix=$BUILD_DIR
make && make install

# Install ncurses from source
cd ../ncurses-6.1
./configure --prefix=$BUILD_DIR
make && make install

# Install tmux from source
cd ../tmux-$TMUX_VERSION
./configure --prefix=$BUILD_DIR LDFLAGS="-L$BUILD_DIR/lib" CFLAGS="-I$BUILD_DIR/include" 
make && make install

# Clean up
rm ../*.tar.gz

# Add tmux to PATH
cd ~
export PATH=$PATH:$BUILD_DIR/bin
