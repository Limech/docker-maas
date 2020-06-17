#!/bin/bash

tail -f /dev/null

if [ ! -f "/maas-init" ]; then
   maas createadmin --username=admin --email=${ADMIN_EMAIL} --password=${ADMIN_PASSWORD}
   #maas init --mode region+rack --maas-url http://${HOST_IP}:5240/MAAS/ --database-host localhost --database-name ${POSTGRES_DB} --database-user ${POSTGRES_USER} --database-pass ${POSTGRES_PASSWORD}
   touch /maas-init
fi	
