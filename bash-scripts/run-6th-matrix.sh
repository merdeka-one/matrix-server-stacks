#!/bin/bash
ABS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_DIR="$(dirname "$ABS_DIR" )"
SCRIPTS_DIR="$(echo ${ROOT_DIR}/bash-scripts)"

source ${SCRIPTS_DIR}/bash_data

cd $ROOT_DIR
docker restart $CONTAINER_NAME_SYNAPSE  $CONTAINER_NAME_MAUTRIX_TELEGRAM  $CONTAINER_NAME_MAUTRIX_WHATSAPP


docker stop $CONTAINER_NAME_NGINX_PM 

export M_TELGM_PREFIX
cp ${TEMPLATES_DIR}/1.conf                                ${NGINX_PM_LOCAL_FOLDER}nginx/proxy_host/
perl -pi -e 's/TELEGRAM_PREFIX/$ENV{M_TELGM_PREFIX}/'     ${NGINX_PM_LOCAL_FOLDER}nginx/proxy_host/1.conf
sudo chown root:root   ${NGINX_PM_LOCAL_FOLDER}nginx/proxy_host/1.conf
$(${SCRIPTS_DIR}/sqlite/sqlite-cli.sh  $NGINX_PM_SQLITE_FILE     ".read /root/db/enable-url.sql")
sudo rsync -aAzP $NGINX_PM_LOCAL_FOLDER  /var/lib/docker/volumes/${DIR}_data-nginx-pxy-mgr/_data/

docker start $CONTAINER_NAME_NGINX_PM
sleep 4s
docker restart $CONTAINER_NAME_SYNAPSE  $CONTAINER_NAME_MAUTRIX_TELEGRAM  $CONTAINER_NAME_MAUTRIX_WHATSAPP
