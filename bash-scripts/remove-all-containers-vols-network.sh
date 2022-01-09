#!/bin/bash
ABS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source ${ABS_DIR}/bash_data

for i in    $CONTAINER_NAME_NGINX_PM \
            $CONTAINER_NAME_SYNAPSE \
            $CONTAINER_NAME_DB_SYNAPSE \
            $CONTAINER_NAME_SYNAPSE_ADMIN \
            $CONTAINER_NAME_MA1SD \
            $CONTAINER_NAME_DB_MA1SD \
            $CONTAINER_NAME_MAUTRIX_TELEGRAM \
            $CONTAINER_NAME_DB_MAUTRIX_TELEGRAM \
            $CONTAINER_NAME_MAUTRIX_WHATSAPP \
            $CONTAINER_NAME_DB_MAUTRIX_WHATSAPP
do
    docker  stop $i
    docker  rm   $i
done



if [ "$1" == "--vol-exclude-nginx" ]; then
    docker volume rm $(docker volume ls --format {{.Name}} | grep -i $DIR  | grep -v nginx ) 
elif [ "$1" == "--vols" ]; then
    echo 'volumes are not deleted'
else
    for i in $(docker volume ls --format {{.Name}} | grep -i $DIR )
    do
        docker volume rm $i
    done
fi



for i in $(docker network ls --format {{.Name}} | grep -i $DIR )
do
    docker network rm $i
done
