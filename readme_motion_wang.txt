

-----------10/30/25 tool_1 counter runner--------------------------------
when ctrl c client, how to delete the runner at server side?
or should the next client kill the current runner and create a new runner?

----------------------------------------------------
docker compose -f docker/docker-compose.build.yml build

    command[0][0]=random.random()
    command[0][1]=random.random()

/g1/left_wrist_yaw_link
/g1/joints/left_wrist_yaw_joint
/g1/joints/right_wrist_roll_joint

/World/Franka/panda_hand/panda_finger_joint1

panda:
python3 -m motion.tool --log-level info --base http://dex:9050 quick --control xbox --file franka_simplestack_flat.usd --runner isaac --effector /World/Franka/panda_hand --device cuda --no-tick --gripper /World/Franka/panda_hand/panda_finger_joint1 --gripper /World/Franka/panda_hand/panda_finger_joint2

unitree:
python3 -m motion.tool --log-level info --base http://dex:9050 quick --control xbox --file g1_flat.usd --runner isaac --effector /g1/left_wrist_yaw_link --device cuda --no-tick --gripper /g1/joints/left_wrist_yaw_joint
