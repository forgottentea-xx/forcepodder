#! /bin/bash

# ARE YOU SERIOUS, WE NEED TO INSTALL A FUCKING COMPILER FROM SOURCE?!?!

# I jacked this from here: https://github.com/frol/docker-alpine-fpc/blob/master/Dockerfile

FPC_VERSION="3.0.0"
FPC_ARCH="x86_64-linux"

apk add --no-cache binutils
cd /tmp && \
mkdir fpc && \
wget "ftp://gd.tuwien.ac.at/languages/pascal/fpc/dist/${FPC_VERSION}/${FPC_ARCH}/fpc-${FPC_VERSION}.${FPC_ARCH}.tar" -O fpc.tar && \
tar xf "fpc.tar" && \
cd "fpc-${FPC_VERSION}.${FPC_ARCH}" && \
rm demo* doc* && \
echo -e '/usr\nN\nN\nN\n' | sh ./install.sh && \
cd / && \
rm -r "/tmp/fpc"*

# now get xidel
cd /tmp
git clone https://github.com/benibela/xidel
./xidel/build.sh

rm -rf /tmp/xidel
