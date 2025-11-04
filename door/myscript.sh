#!/bin/bash
# /usr/local/bin/my_root_script.sh

echo "myscript 1 try" >> /var/log/my_root_script.log
ssh -o ServerAliveInterval=60 -N -R 9020:localhost:22 jackal@dex -p 80  >> /var/log/my_root_script.log
