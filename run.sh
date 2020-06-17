#!/bin/bash

docker run --rm -d --name=maas --privileged --net=host maas:latest

echo -e "Now run the following:"
echo -e "docker exec -it maas maas createadmin --username=admin --password=passw0rd --email=limech@gmail.com"

echo -e "Open web browser at http://localhost:5240/MAAS/"
