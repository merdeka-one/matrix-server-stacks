#!/bin/bash
ABS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_DIR="$( dirname  $(dirname "$ABS_DIR") )"
SCRIPTS_DIR="$(echo ${ROOT_DIR}/bash-scripts)"

SQLITE_VER='latest'
SQLITE_CLI='sqlite3'

if [ -z "$1" ]; then
    echo "No sqlite db file supplied"
    exit 1
fi

 
#echo $SQLITE_CLI "${@:2}"
docker run --rm -it \
  -v ${SCRIPTS_DIR}/sqlite/mount:/root/db \
  -v $1:/root/db/sqlite3 \
  nouchka/sqlite3:${SQLITE_VER} \
  $SQLITE_CLI "${@:2}"

#  -v ${ROOT_DIR}/data/nginx-proxy-manager/database.sqlite:/root/db/sqlite3 \
#  SQLITE_CLI "$1"
