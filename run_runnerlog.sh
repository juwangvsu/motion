docker logs -f motion-runner 2>&1 | tee ttt.txt
cat ttt.txt |grep "send=" |awk -F= '{print $2}'
