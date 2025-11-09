python3 -m motion.tool --log-level info --base http://dex:9050 quick --control xbox --file franka_simplestack_flat.usd --runner counter --effector /World/Franka/panda_hand --device cuda --no-tick --gripper /World/Franka/panda_hand/panda_finger_joint1 --gripper /World/Franka/panda_hand/panda_finger_joint2 2>&1 | tee tt2.txt
cat tt2.txt |grep "Step=" |awk -F= '{print $2}' > ttt_client.txt

