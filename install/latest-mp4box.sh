#! /bin/bash

cd /tmp
git clone https://github.com/gpac/gpac.git
cd gpac
./configure --static-mp4box --use-zlib=no
make -j4

cd /tmp
rm -rf gpac
