docker logs -f motion-runner 2>&1 | tee ttt.txt
cat ttt.txt |grep "recv=" |awk -F= '{print $2}' > tttrunner.txt
