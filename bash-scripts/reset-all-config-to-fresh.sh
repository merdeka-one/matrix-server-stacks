#!/bin/bash
ABS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_DIR="$(dirname "$ABS_DIR" )"
SCRIPTS_DIR="$(echo ${ROOT_DIR}/bash-scripts)"

source ${SCRIPTS_DIR}/bash_data


cp ${TEMPLATES_DIR}/.env.$EXT_RESET   ${ROOT_DIR}/.env
cp ${SCRIPTS_DIR}/bash_user_data_simple                ${SCRIPTS_DIR}/bash_user_data_simple.old
cp ${TEMPLATES_DIR}/bash_user_data_simple.$EXT_RESET   ${SCRIPTS_DIR}/bash_user_data_simple
cp ${TEMPLATES_DIR}/bash_user_data_details.$EXT_RESET  ${SCRIPTS_DIR}/bash_user_data_details

cp ${SYNAPSE_LOCAL_FOLDER}homeserver.yaml.$EXT_RESET         ${SYNAPSE_LOCAL_FOLDER}homeserver.yaml-${FINAL_RC}
cp ${MA1SD_LOCAL_FOLDER}ma1sd.yaml.$EXT_RESET                ${MA1SD_LOCAL_FOLDER}ma1sd.yaml-${FINAL_RC}
cp ${MAUTRIX_TELEGRAM_LOCAL_FOLDER}config.yaml.$EXT_RESET    ${MAUTRIX_TELEGRAM_LOCAL_FOLDER}config.yaml-${FINAL_RC}
cp ${MAUTRIX_WHATSAPP_LOCAL_FOLDER}config.yaml.$EXT_RESET    ${MAUTRIX_WHATSAPP_LOCAL_FOLDER}config.yaml-${FINAL_RC}

cp ${TEMPLATES_DIR}/database.sqlite                          ${NGINX_PM_LOCAL_FOLDER}
cp ${TEMPLATES_DIR}/update-nginx-proxy-manager.sql           ${SCRIPTS_DIR}/sqlite/mount/

sudo rm ${NGINX_PM_LOCAL_FOLDER}nginx/proxy_host/1.conf

