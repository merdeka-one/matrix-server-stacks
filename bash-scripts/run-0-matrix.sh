#!/bin/bash
ABS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_DIR="$(dirname "$ABS_DIR" )"
SCRIPTS_DIR="$(echo ${ROOT_DIR}/bash-scripts)"

source ${SCRIPTS_DIR}/bash_data


#### Install Component ####
if [ "$(grep -Ei 'debian|buntu|mint' /etc/*release)" ]; then
    sudo apt-get install -y pwgen uuid-runtime
else
    sudo yum install -y epel-release
    sudo yum install -y pwgen uuid-runtime
fi
#### ENDS ####


#### Generate passwords for DB connections ####

TEMP=$(pwgen -c -n 15 1)
sed -i "s/POSTGRES_SYNAPSE_PASSWORD=.*/POSTGRES_SYNAPSE_PASSWORD='${TEMP}'/"   ${SCRIPTS_DIR}/bash_user_data_details
TEMP=$(pwgen -c -n 15 1)
sed -i "s/POSTGRES_MA1SD_PASSWORD=.*/POSTGRES_MA1SD_PASSWORD='${TEMP}'/"  ${SCRIPTS_DIR}/bash_user_data_details
TEMP=$(pwgen -c -n 15 1)
sed -i "s/POSTGRES_TELEGRAM_PASSWORD=.*/POSTGRES_TELEGRAM_PASSWORD='${TEMP}'/"   ${SCRIPTS_DIR}/bash_user_data_details
TEMP=$(pwgen -c -n 15 1)
sed -i "s/POSTGRES_WHATSAPP_PASSWORD=.*/POSTGRES_WHATSAPP_PASSWORD='${TEMP}'/"   ${SCRIPTS_DIR}/bash_user_data_details

#### ENDS ####

#### Generate App Service Module Shared Secret ####

TEMP=$(pwgen -s 128 1)
sed -i "s/MOD_SHARED_SECRET=.*/MOD_SHARED_SECRET='${TEMP}'/"    ${SCRIPTS_DIR}/bash_user_data_details

#### ENDS ####

#### Generate Telegram URL for webhook ####

TEMP=$(uuidgen)
sed -i "s/M_TELGM_PREFIX=.*/M_TELGM_PREFIX=\"${TEMP}\"/"     ${SCRIPTS_DIR}/bash_user_data_details

#### ENDS ####
