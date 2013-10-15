#!/bin/bash

echo "* Update repolist before install *"
sudo apt-get update

echo "* Install dependencies *"
sudo apt-get install g++ build-essential zlibc zlib1g zlib1g-dev

echo "* Configure *"
make config prefix=~/bin/minisat/

echo "* Install minisat *"
sudo make install


