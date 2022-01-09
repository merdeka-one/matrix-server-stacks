#!/bin/bash
ABS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_DIR="$(dirname "$ABS_DIR" )"
SCRIPTS_DIR="$(echo ${ROOT_DIR}/bash-scripts)"

source ${SCRIPTS_DIR}/bash_data



# Replace keys and values from bash_user_data

#### FILL UP DOCKER .ENV ####

sed -i "s/NODE=''/NODE='${NODE}'/"    ${ROOT_DIR}/.env
sed -i "s/POSTGRES_SYNAPSE_USER=''/POSTGRES_SYNAPSE_USER='${POSTGRES_SYNAPSE_USER}'/"    ${ROOT_DIR}/.env
sed -i "s/POSTGRES_SYNAPSE_PASSWORD=''/POSTGRES_SYNAPSE_PASSWORD='${POSTGRES_SYNAPSE_PASSWORD}'/"    ${ROOT_DIR}/.env
sed -i "s/POSTGRES_MA1SD_USER=''/POSTGRES_MA1SD_USER='${POSTGRES_MA1SD_USER}'/"    ${ROOT_DIR}/.env
sed -i "s/POSTGRES_MA1SD_PASSWORD=''/POSTGRES_MA1SD_PASSWORD='${POSTGRES_MA1SD_PASSWORD}'/"    ${ROOT_DIR}/.env
sed -i "s/POSTGRES_TELEGRAM_USER=''/POSTGRES_TELEGRAM_USER='${POSTGRES_TELEGRAM_USER}'/"    ${ROOT_DIR}/.env
sed -i "s/POSTGRES_TELEGRAM_PASSWORD=''/POSTGRES_TELEGRAM_PASSWORD='${POSTGRES_TELEGRAM_PASSWORD}'/"    ${ROOT_DIR}/.env
sed -i "s/POSTGRES_WHATSAPP_USER=''/POSTGRES_WHATSAPP_USER='${POSTGRES_WHATSAPP_USER}'/"    ${ROOT_DIR}/.env
sed -i "s/POSTGRES_WHATSAPP_PASSWORD=''/POSTGRES_WHATSAPP_PASSWORD='${POSTGRES_WHATSAPP_PASSWORD}'/"    ${ROOT_DIR}/.env

#### ENDS ####


#### DOCKER-COMPOSE ADJUSTMENT ####
if [[ ! $(cat docker-compose.yml | grep -i "nginx-pxy-mgr-${NODE}") ]]; then
    export NODE
    perl -pi -e  '!$x && s/nginx-pxy-mgr-.*:/nginx-pxy-mgr-$ENV{NODE}:/ && ($x=1)'    ${ROOT_DIR}/docker-compose.yml
fi
#### ENDS ####

#### Docker create external Network matrix-nodes for multi-nodes (future roadmap) ####
if [[ ! $(docker network ls --format {{.Name}} | grep -i 'matrix-nodes' ) ]]; then
    docker network create matrix-nodes
fi
#### ENDS ####


#### HS CONFIG BEGINS ####

source ${SCRIPTS_DIR}/fill_up_synapse_config

#### ENDS ####



#### MA1SD CONFIG BEGINS ####

source ${SCRIPTS_DIR}/fill_up_ma1sd_config

#### ENDS ####


#### MAUTRIX TELEGRAM CONFIG BEGINS ####

source ${SCRIPTS_DIR}/fill_up_mautrix_telegram_config

#### ENDS ####


#### MAUTRIX WHATSAPP CONFIG BEGINS ####

source ${SCRIPTS_DIR}/fill_up_mautrix_whatsapp_config

#### ENDS ####


#### Pull Repository For Synapse-Admin ####
SERVICE_DIR="${ROOT_DIR}/synapse-admin/"
if [ ! -d "$SERVICE_DIR" ]; then
    mkdir -p $SERVICE_DIR
    git clone "https://github.com/Awesome-Technologies/synapse-admin.git" $SERVICE_DIR 
fi
#### ENDS ####

#### Pull Repository For AS Module Shared Secret Auth ####
SERVICE_DIR="${ROOT_DIR}/synapse/extensions/shared-secret-auth/"
if [ ! -d "$SERVICE_DIR" ]; then
    mkdir -p $SERVICE_DIR
    git clone "https://github.com/devture/matrix-synapse-shared-secret-auth" $SERVICE_DIR
fi
#### ENDS ####

#### Pull Repository For Mautrix Telegram ####
SERVICE_DIR="${ROOT_DIR}/mautrix-telegram/"
if [ ! -d "$SERVICE_DIR" ]; then
    mkdir -p $SERVICE_DIR
    git clone "https://github.com/mautrix/telegram.git" $SERVICE_DIR 
fi
#### ENDS ####

#### Pull Repository For Mautrix Whatsapp ####
SERVICE_DIR="${ROOT_DIR}/mautrix-whatsapp/"
if [ ! -d "$SERVICE_DIR" ]; then
    mkdir -p $SERVICE_DIR
    git clone "https://github.com/mautrix/whatsapp.git" $SERVICE_DIR 
fi
#### ENDS ####




#### STEP 1: GENERATE HOMESERVER.YAML FRESH CONFIG ####

cd $ROOT_DIR

docker-compose --env-file $DOCKER_ENV run --rm -e SYNAPSE_SERVER_NAME=$SERVER_NAME -e SYNAPSE_REPORT_STATS=yes synapse generate

sudo cp $(sudo find /var/lib/docker/volumes/${DIR}_data-synapse/  -name homeserver.yaml) $SYNAPSE_LOCAL_FOLDER

#### ENDS ####



#### Grab macaroon and form values, put it on USER DATA AND FINAL_RC ####

TEMP=$(sudo cat ${SYNAPSE_LOCAL_FOLDER}homeserver.yaml  | grep -i macaroon_secret | cut -d'"' -f2)
#echo $TEMP
export TEMP
perl -pi -e 's/HS_MACAROON=.*/HS_MACAROON="$ENV{TEMP}"/'      ${SCRIPTS_DIR}/bash_user_data_details
perl -pi -e 's/macaroon_secret_key:.*/macaroon_secret_key: "$ENV{TEMP}"/'   ${SYNAPSE_LOCAL_FOLDER}homeserver.yaml-${FINAL_RC}
#sed -i "s/macaroon_secret_key:.*/macaroon_secret_key: \"${HS_MACAROON}\"/" ${SYNAPSE_LOCAL_FOLDER}homeserver.yaml-${FINAL_RC}


TEMP=$(sudo cat ${SYNAPSE_LOCAL_FOLDER}homeserver.yaml  | grep -i form_secret | cut -d'"' -f2)
#echo $TEMP
#perl -pe 's/x/$ENV{REPL}/' <<< "STARTxEND"
export TEMP
perl -pi -e 's/HS_FORM=.*/HS_FORM="$ENV{TEMP}"/'              ${SCRIPTS_DIR}/bash_user_data_details
perl -pi -e 's/form_secret:.*/form_secret: "$ENV{TEMP}"/'   ${SYNAPSE_LOCAL_FOLDER}homeserver.yaml-${FINAL_RC}
#sed -i "s/form_secret:.*/form_secret: \"${HS_FORM}\"/" ${SYNAPSE_LOCAL_FOLDER}homeserver.yaml-${FINAL_RC}

#### ENDS ####
