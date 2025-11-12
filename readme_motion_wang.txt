----------11/12/25 run_diff_ik gamepad ---------------
root@hptitan-pctt:/workspace/isaaclab# ./isaaclab.sh -p /app/run_diff_ik.py --num_envs 1
modify run_diff_ik to use gamepad xbox, relative mode

docker run  -d -t --restart always --privileged --entrypoint bash --gpus all -e "ACCEPT_EULA=Y" --network=host     -e "PRIVACY_CONSENT=Y" -v $PWD:/app    -v ~/docker/isaac-sim/cache/kit:/isaac-sim/kit/cache:rw     -v ~/docker/isaac-sim/cache/ov:/root/.cache/ov:rw     -v ~/docker/isaac-sim/cache/pip:/root/.cache/pip:rw     -v ~/docker/isaac-sim/cache/glcache:/root/.cache/nvidia/GLCache:rw     -v ~/docker/isaac-sim/cache/computecache:/root/.nv/ComputeCache:rw     -v ~/docker/isaac-sim/logs:/root/.nvidia-omniverse/logs:rw     -v ~/docker/isaac-sim/data:/root/.local/share/ov/data:rw     -v ~/docker/isaac-sim/documents:/root/Documents:rw -e DISPLAY=${DISPLAY} -e QT_X11_NO_MITSHM=1 -v /tmp/.X11-unix:/tmp/.X11-unix:rw -v ${XAUTHORITY:-$HOME/.Xauthority}:/root/.Xauthority  --name isaaclab jwang3vsu/isaaclab:2.2.0 

----------11/8/25 debuging log ---------------

run_clientlog.sh
run_runnerlog.sh

client:
	2>&1 | tee tt2.txt
	cat tt2.txt |grep "Step=" |awk -F= '{print $2}'
server:
	docker logs -f motion-runner 2>&1 | tee ttt.txt
	cat ttt.txt |grep "recv=" |awk -F= '{print $2}'

----------11/5/25 websocket client to server communicate ---------------
f_keyboard ctl-c resume terminal setting 
add f_produce() to put stream data to FILO queue
	supress timeout inside to prevent task terminating

python3 -m motion.tool_3 --log-level info --base http://dex:9051 quick --control keyboard --file franka_simplestack_flat.usd --runner counter --effector /World/Franka/panda_hand --device cuda --no-tick --gripper /World/Franka/panda_hand/panda_finger_joint1 --gripper /World/Franka/panda_hand/panda_finger_joint2 2>&1 | tee tt2.txt

----------11/6/25 raspberry pi work ---------------
fix src/motion/docker-compose.yml
	$PWD:/workspace empty if launched from motion-work, so replace
		with /tmp/workspace:/workspace
 
----------11/4/25 raspberry pi work ---------------
don't build motion-runner-isaac

.docker/docker-compose.build_pi.yml

run_nofetch_pi.sh
	build images minus isaac
run_nb.sh 
	same as intel machine
when run client, runner should be counter or ros, but not isaac

----------11/2/25 websocket client to server communicate ---------------

issues:
	xbox press button, tool_1.py send the data, but server receive not.
	   release button, server receive the event of button up.

	the client sent both events, but server only get the 2nd one.

	fix: fault at server side. the send_loop somehow hold up ws stream.
	server.py:
		@app.websocket("/session/{session:uuid}/stream")	
		612         done, pending = await asyncio.wait(
		613             {recv_task}, return_when=asyncio.FIRST_EXCEPTION
		614             #{recv_task, send_task}, return_when=asyncio.FIRST_EXCEPTION
		615         )

the reason send_loop causing problem is because await sub.next_msg() timeout exception cause ws
to be closed, thus cause the receive_text to error and canceled.

-----------10/30/25 tool_1 counter runner--------------------------------
when ctrl c client, how to delete the runner at server side?
or should the next client kill the current runner and create a new runner?
	fix: tool_1.py add session.stop() to the final clause so ctrl c will go there.
	
counter:
	python3 -m motion.tool_1 --log-level info --base http://dex:9050 quick --control keyboard --file franka_simplestack_flat.usd --runner counter --effector /World/Franka/panda_hand --device cuda --no-tick --gripper /World/Franka/panda_hand/panda_finger_joint1 --gripper /World/Franka/panda_hand/panda_finger_joint2

ros:
	python3 -m motion.tool_1 --log-level info --base http://dex:9050 quick --control keyboard --file franka_simplestack_flat.usd --runner ros --effector /World/Franka/panda_hand --device cuda --no-tick --gripper /World/Franka/panda_hand/panda_finger_joint1 --gripper /World/Franka/panda_hand/panda_finger_joint2
		right now only print the msg if client msg is keyboard
		if gamepad it publish Joy()
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
