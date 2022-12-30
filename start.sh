#!/bin/bash

cp .env docker/.env

source .env

# Cria uma iamgem docker do sendportal usando Dockerfile
docker build -t ${CONTAINER_NAME} docker

# Cria um container redis
docker run -d -p 6379:6379 --name ${CONTAINER_NAME}_redis --rm redis

# Run app
# docker run --rm -d -p 8181:8181 --name ${CONTAINER_NAME} --link ${CONTAINER_NAME}_redis:redis -v /app ${CONTAINER_NAME}
docker run --rm -d -p 8181:8181 --name ${CONTAINER_NAME} -v /app ${CONTAINER_NAME}

# Run sendportal setup
docker exec -it ${CONTAINER_NAME} /app/artisan key:generate  
docker exec -it ${CONTAINER_NAME} service cron start
docker exec -it ${CONTAINER_NAME} /app/artisan sp:install 

