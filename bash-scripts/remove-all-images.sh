#!/bin/bash
ABS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source ${ABS_DIR}/bash_data


for i in $(docker  image ls --format {{.Repository}} | grep $DIR )
do
    docker rmi $i
done



#docker rmi $(docker images --format "{{.Repository}}:{{.Tag}}" | grep -i $IMAGE_NAME_NGINX_PXY_MGR_KEYWORD )

#docker rmi $(docker images --format "{{.Repository}}:{{.Tag}}" | grep -i $IMAGE_NAME_SYNAPSE_KEYWORD )

#docker rmi $(docker images --format "{{.Repository}}:{{.Tag}}" | grep -i $IMAGE_NAME_DB_SYNAPSE_KEYWORD )

#docker rmi $(docker images --format "{{.Repository}}:{{.Tag}}" | grep -i $IMAGE_NAME_MA1SD_KEYWORD )

#docker rmi $(docker images --format "{{.Repository}}:{{.Tag}}" | grep -i $IMAGE_NAME_DB_MA1SD_KEYWORD )

