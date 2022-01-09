#!/bin/bash
ABS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_DIR="$(dirname "$ABS_DIR" )"
SCRIPTS_DIR="$(echo ${ROOT_DIR}/bash-scripts)"

source ${SCRIPTS_DIR}/bash_data
source ${SCRIPTS_DIR}/bash_functions


sudo cp ${MA1SD_LOCAL_FOLDER}ma1sd.yaml-${FINAL_RC}   ${MA1SD_LOCAL_FOLDER}ma1sd.yaml
sudo chown root:root  ${MA1SD_LOCAL_FOLDER}ma1sd.yaml
sudo chmod 644  ${MA1SD_LOCAL_FOLDER}ma1sd.yaml
sudo cp ${MA1SD_LOCAL_FOLDER}ma1sd.yaml $(sudo find /var/lib/docker/volumes/${DIR}_data-id-ma1sd-etc/  -name ma1sd.yaml)


push_telegram_config_to_volume
push_whatsapp_config_to_volume

cd $ROOT_DIR
docker start $CONTAINER_NAME_NGINX_PM $CONTAINER_NAME_MA1SD $CONTAINER_NAME_MAUTRIX_TELEGRAM $CONTAINER_NAME_MAUTRIX_WHATSAPP
