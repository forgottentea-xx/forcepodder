#! /bin/bash

cd /tmp
mkdir xidel
cd xidel
wget http://sourceforge.net/projects/videlibri/files/Xidel/Xidel%200.8.4/xidel-0.8.4.linux64.tar.gz/download   -O - | tar -xz   && mv xidel /bin
mkdir /lib64 && ln -s /lib/ld-musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

cd /tmp
rm -rf xidel
