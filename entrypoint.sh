#!/usr/bin/env bash

set -e

if [ "$1" = 'unturned' ]; then
    /home/steam/unturned/Unturned_Headless.x86_64 -logfile 2>&1 -batchmode -nographics +InternetServer/tsvr1
else
    exec "$@"
fi