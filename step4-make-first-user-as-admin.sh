#!/bin/bash
ABS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
#ROOT_DIR="$(dirname "$ABS_DIR" )"
ROOT_DIR="$(echo "$ABS_DIR" )"
SCRIPTS_DIR="$(echo ${ROOT_DIR}/bash-scripts)"

source ${SCRIPTS_DIR}/bash_data


QUERY="UPDATE users SET admin = 1 WHERE name = '@${1}:${SERVER_NAME}';"

if [[ ! -z "$1" ]]; then
    echo "$QUERY" >> ${ROOT_DIR}/admin.sql
    docker cp ${ROOT_DIR}/admin.sql   ${CONTAINER_NAME_DB_SYNAPSE}:/root/
    docker exec -it db-postgres-synapse-t1 psql -U $POSTGRES_SYNAPSE_USER -d synapse -f /root/admin.sql
    rm ${ROOT_DIR}/admin.sql
else 
    echo "Please enter registed username to set as admin"
    echo "For example: './step4-make-first-user-as-admin.sh  testuser'"
fi
