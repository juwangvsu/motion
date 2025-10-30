#docker compose -f src/motion/docker-compose.yml -p motion down motion up server live nats react model minio work rtsp --remove-orphans -v
docker compose -f src/motion/docker-compose.yml -p motion down --remove-orphans -v
#docker rm -f motion-node-isaac
#NVIDIA_VISIBLE_DEVICES=all docker compose -f docker/docker-compose.yml -p motion up -d --force-recreate
#docker compose -f src/motion/docker-compose.yml -p motion up server live nats react model minio work rtsp -d --force-recreate
docker compose -f src/motion/docker-compose.yml -p motion up -d --force-recreate
sleep 50 
docker ps |grep motion
