#!/bin/bash
ABS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_DIR="$(dirname "$ABS_DIR" )"
SCRIPTS_DIR="$(echo ${ROOT_DIR}/bash-scripts)"

source ${SCRIPTS_DIR}/bash_data
source ${SCRIPTS_DIR}/bash_functions

SYNAPSE_AS_DIR_TELEGRAM='as/mautrix-telegram'
SYNAPSE_AS_DIR_WHATSAPP='as/mautrix-whatsapp'

cd $ROOT_DIR
docker stop $CONTAINER_NAME_SYNAPSE  $CONTAINER_NAME_MAUTRIX_TELEGRAM  $CONTAINER_NAME_MAUTRIX_WHATSAPP


#### Grab Telegram as_token and hs_token values, put it on USER DATA AND FINAL_RC ####

sudo cp $(sudo find /var/lib/docker/volumes/${DIR}_data-mautrix-telegram/  -name config.yaml) $MAUTRIX_TELEGRAM_LOCAL_FOLDER

fetch_telegram_as_hs_tokens

push_telegram_config_to_volume

#### ENDS ####

#### Copy Telegram registration.yaml to Synapse Local Folder ####

sudo cp $(sudo find /var/lib/docker/volumes/${DIR}_data-mautrix-telegram/  -name registration.yaml)  ${MAUTRIX_TELEGRAM_LOCAL_FOLDER}registration.yaml
sudo cp ${MAUTRIX_TELEGRAM_LOCAL_FOLDER}registration.yaml   ${SYNAPSE_LOCAL_FOLDER}as/mautrix-telegram/registration.yaml

#### ENDS ####





#### Grab Whatsapp as_token and hs_token values, put it on USER DATA AND FINAL_RC ####

sudo cp $(sudo find /var/lib/docker/volumes/${DIR}_data-mautrix-whatsapp/  -name config.yaml) $MAUTRIX_WHATSAPP_LOCAL_FOLDER

fetch_whatsapp_as_hs_tokens

push_whatsapp_config_to_volume

#### ENDS ####

#### Copy Whatsapp registration.yaml to Synapse Local Folder ####

sudo cp $(sudo find /var/lib/docker/volumes/${DIR}_data-mautrix-whatsapp/  -name registration.yaml)  ${MAUTRIX_WHATSAPP_LOCAL_FOLDER}registration.yaml

#### Registration.yaml for whatsapp ####

sudo sed -i "s/url:.*/url: http:\/\/mautrix-whatsapp:29318/" ${MAUTRIX_WHATSAPP_LOCAL_FOLDER}registration.yaml
sudo sed -i "s/as_token:.*/as_token: ${M_WHATSP_AS_TOKEN}/" ${MAUTRIX_WHATSAPP_LOCAL_FOLDER}registration.yaml
sudo sed -i "s/hs_token:.*/hs_token: ${M_WHATSP_HS_TOKEN}/" ${MAUTRIX_WHATSAPP_LOCAL_FOLDER}registration.yaml
sudo sed -i "s/example.com/${SERVER_NAME}/" ${MAUTRIX_WHATSAPP_LOCAL_FOLDER}registration.yaml

#### ENDS ####

sudo cp ${MAUTRIX_WHATSAPP_LOCAL_FOLDER}registration.yaml   ${SYNAPSE_LOCAL_FOLDER}as/mautrix-whatsapp/registration.yaml

#### ENDS ####




sudo mkdir -p /var/lib/docker/volumes/${DIR}_data-synapse/_data/${SYNAPSE_AS_DIR_TELEGRAM}
sudo mkdir -p /var/lib/docker/volumes/${DIR}_data-synapse/_data/${SYNAPSE_AS_DIR_WHATSAPP}

sudo cp ${SYNAPSE_LOCAL_FOLDER}as/mautrix-telegram/registration.yaml   /var/lib/docker/volumes/${DIR}_data-synapse/_data/${SYNAPSE_AS_DIR_TELEGRAM}/registration.yaml
sudo cp ${SYNAPSE_LOCAL_FOLDER}as/mautrix-whatsapp/registration.yaml   /var/lib/docker/volumes/${DIR}_data-synapse/_data/${SYNAPSE_AS_DIR_WHATSAPP}/registration.yaml

cd $ROOT_DIR
docker start $CONTAINER_NAME_SYNAPSE  $CONTAINER_NAME_MAUTRIX_TELEGRAM  $CONTAINER_NAME_MAUTRIX_WHATSAPP
