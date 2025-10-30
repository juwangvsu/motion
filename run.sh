git fetch
git checkout .
git rebase
docker compose -f src/motion/docker-compose.yml -p motion down --remove-orphans -v
docker rm -f motion-node-isaac
docker compose -f .docker/docker-compose.build.yml build
#NVIDIA_VISIBLE_DEVICES=all docker compose -f docker/docker-compose.yml -p motion up -d --force-recreate
docker compose -f src/motion/docker-compose.yml -p motion up -d --force-recreate
sleep 50 
docker ps |grep motion
