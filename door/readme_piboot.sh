
-------------start two tunnels via dex: ssh and port 80 --------------------

setup:
	scripts run as root after boot, so ssh-copy-id need to use root sshkey
	sudo bash
	ssh-keygen
	ssh-copy-id -p 80 jackal@dex


cp *.service /etc/systemd/system/
cp myscri*.sh /home/raspberrypi

sudo systemctl enable myscript.service
sudo systemctl enable myscript2.service
sudo systemctl start myscript.service
sudo systemctl start myscript2.service

