#!/bin/bash
ABS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_DIR="$(dirname "$ABS_DIR" )"
SCRIPTS_DIR="$(echo ${ROOT_DIR}/bash-scripts)"

source ${SCRIPTS_DIR}/bash_data
source ${SCRIPTS_DIR}/bash_functions

cd $ROOT_DIR
docker stop $CONTAINER_NAME_NGINX_PM $CONTAINER_NAME_MA1SD $CONTAINER_NAME_MAUTRIX_TELEGRAM $CONTAINER_NAME_MAUTRIX_WHATSAPP


export M_TELGM_PREFIX
perl -pi -e 's/TELEGRAM_PREFIX/$ENV{M_TELGM_PREFIX}/'     ${SCRIPTS_DIR}/sqlite/mount/update-nginx-proxy-manager.sql
export SERVER_NAME
perl -pi -e 's/SERVER_NAME/$ENV{SERVER_NAME}/'     ${SCRIPTS_DIR}/sqlite/mount/update-nginx-proxy-manager.sql
#echo $NGINX_PM_SQLITE_FILE
$(${SCRIPTS_DIR}/sqlite/sqlite-cli.sh  $NGINX_PM_SQLITE_FILE     ".read /root/db/update-nginx-proxy-manager.sql")
sudo rsync -aAzP $NGINX_PM_LOCAL_FOLDER  /var/lib/docker/volumes/${DIR}_data-nginx-pxy-mgr/_data/


sudo cp $(sudo find /var/lib/docker/volumes/${DIR}_data-id-ma1sd-etc/  -name ma1sd.yaml) $MA1SD_LOCAL_FOLDER
#echo 'File ma1sd.yaml settings is copied to data folder. Please adjust that one'



sudo cp $(sudo find /var/lib/docker/volumes/${DIR}_data-mautrix-telegram/  -name config.yaml) $MAUTRIX_TELEGRAM_LOCAL_FOLDER
echo 'File config.yaml settings is copied to mautrix-telegram data folder. Please adjust that one'

#### Grab shared_secret value, put it on USER DATA AND FINAL_RC ####

TEMP=$(sudo cat ${MAUTRIX_TELEGRAM_LOCAL_FOLDER}config.yaml  | grep -i 'shared_secret:' | grep -Po 'shared_secret:\s+\K[^ ]+')
#echo $TEMP
export TEMP
perl -pi -e 's/M_TELGM_API_SECRET=.*/M_TELGM_API_SECRET="$ENV{TEMP}"/'    ${SCRIPTS_DIR}/bash_user_data_details
perl -pi -e 's/shared_secret:.*/shared_key: $ENV{TEMP}/'         ${MAUTRIX_TELEGRAM_LOCAL_FOLDER}config.yaml-${FINAL_RC}
#sed -i "s/M_TELGM_API_SECRET=\".*\"/M_TELGM_API_SECRET=\"${TEMP}\"/" ./bash_user_data_details
#sed -i "s/shared_secret: \".*\"/shared_secret: \"${M_TELGM_API_SECRET}\"/" ${MAUTRIX_TELEGRAM_LOCAL_FOLDER}config.yaml-${FINAL_RC}

fetch_telegram_as_hs_tokens

#### ENDS ####



sudo cp $(sudo find /var/lib/docker/volumes/${DIR}_data-mautrix-whatsapp/  -name config.yaml) $MAUTRIX_WHATSAPP_LOCAL_FOLDER
echo 'File config.yaml settings is copied to mautrix-whatsapp data folder. Please adjust that one'

#### Grab shared_secret value, put it on USER DATA AND FINAL_RC ####

TEMP=$(sudo cat ${MAUTRIX_WHATSAPP_LOCAL_FOLDER}config.yaml  | grep -i 'shared_secret:' | grep -Po 'shared_secret:\s+\K[^ ]+')
#echo $TEMP
export TEMP
perl -pi -e 's/M_WHATSP_API_SECRET=.*/M_WHATSP_API_SECRET="$ENV{TEMP}"/'    ${SCRIPTS_DIR}/bash_user_data_details
perl -pi -e 's/shared_secret:.*/shared_key: $ENV{TEMP}/'       ${MAUTRIX_WHATSAPP_LOCAL_FOLDER}config.yaml-${FINAL_RC}
#sed -i "s/M_WHATSP_API_SECRET=\".*\"/M_WHATSP_API_SECRET=\"${TEMP}\"/" ./bash_user_data_details
#sed -i "s/shared_secret: \".*\"/shared_secret: \"${M_WHATSP_API_SECRET}\"/" ${MAUTRIX_WHATSAPP_LOCAL_FOLDER}config.yaml-${FINAL_RC}

fetch_whatsapp_as_hs_tokens

#### ENDS ####

