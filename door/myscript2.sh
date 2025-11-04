#!/bin/bash
# /usr/local/bin/my_root_script.sh

echo "myscript2 try!" >> /var/log/my_root_script.log
ssh -o ServerAliveInterval=60 -N -R 9051:localhost:80 jackal@dex -p 80  >> /var/log/my_root_script.log
