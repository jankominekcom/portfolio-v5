#!/bin/bash


# Create networks and volumes

echo "Creating networks and volumes..."

docker network inspect public-network > /dev/null 2>&1 || docker network create public-network

docker network inspect portfolio-pocketbase-network > /dev/null 2>&1 || docker network create portfolio-pocketbase-network

docker network inspect portfolio-sveltekit-network > /dev/null 2>&1 || docker network create portfolio-sveltekit-network


docker volume inspect portfolio-pocketbase-data-volume > /dev/null 2>&1 || docker volume create portfolio-pocketbase-data-volume

docker volume inspect portfolio-pocketbase-public-volume > /dev/null 2>&1 || docker volume create portfolio-pocketbase-public-volume

docker volume inspect portfolio-pocketbase-hooks-volume > /dev/null 2>&1 || docker volume create portfolio-pocketbase-hooks-volume

echo "Created!"


# Deploying

echo "Deploying..."

docker compose \
    -p jankominek \
    -f docker-compose.yml \
    -f server/docker-compose-portfolio-pocketbase.yml \
    -f client/docker-compose-portfolio-sveltekit.yml \
    up -d

echo "Deployed!"


# Clearing old things

echo "Clearing old things..."

docker system prune -f
docker container prune -f
docker image prune -f
docker network prune -f
docker volume prune -f

echo "Cleared!"

echo "Done!"
