#! /bin/bash

cd /tmp
git clone https://github.com/get-iplayer/get_iplayer
cd get_iplayer
yes | cp get_iplayer /usr/local/bin/get_iplayer
chmod +x /usr/local/bin/get_iplayer
cd /tmp
rm -rf get_iplayer
