docker compose -f src/motion/docker-compose.yml -p motion down --remove-orphans -v
docker rm -f motion-node-isaac
