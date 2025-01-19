#!/bin/bash

echo "Starting Docker containers"
docker-compose down
docker-compose up -d

if [ $? -eq 0 ]; then
    echo "Docker containers started successfully"
else
    echo "Docker containers failed to start"
    docker-compose logs
    exit 1
fi
