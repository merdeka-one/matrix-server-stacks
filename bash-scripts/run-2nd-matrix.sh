#!/bin/bash
ABS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_DIR="$(dirname "$ABS_DIR" )"
SCRIPTS_DIR="$(echo ${ROOT_DIR}/bash-scripts)"

source ${SCRIPTS_DIR}/bash_data


sudo cp ${SYNAPSE_LOCAL_FOLDER}homeserver.yaml-${FINAL_RC}   ${SYNAPSE_LOCAL_FOLDER}homeserver.yaml
sudo chown root:root ${SYNAPSE_LOCAL_FOLDER}homeserver.yaml
sudo chmod 644 ${SYNAPSE_LOCAL_FOLDER}homeserver.yaml

sudo cp ${SYNAPSE_LOCAL_FOLDER}homeserver.yaml $(sudo find /var/lib/docker/volumes/${DIR}_data-synapse/  -name homeserver.yaml)


sudo cp ${SYNAPSE_LOCAL_FOLDER}example.com.log.config ${SYNAPSE_LOCAL_FOLDER}${SERVER_NAME}.log.config


sudo cp ${SYNAPSE_LOCAL_FOLDER}${SERVER_NAME}.log.config $(sudo find /var/lib/docker/volumes/${DIR}_data-synapse/  -name ${SERVER_NAME}.log.config)


cd $ROOT_DIR
docker-compose --env-file $DOCKER_ENV up -d --build

