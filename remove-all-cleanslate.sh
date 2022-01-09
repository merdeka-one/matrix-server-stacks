#!/bin/bash
ABS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
#ROOT_DIR="$(dirname "$ABS_DIR" )"
ROOT_DIR="$(echo "$ABS_DIR" )"
SCRIPTS_DIR="$(echo ${ROOT_DIR}/bash-scripts)"

source ${SCRIPTS_DIR}/remove-all-containers-vols-network.sh
source ${SCRIPTS_DIR}/remove-all-images.sh
source ${SCRIPTS_DIR}/reset-all-config-to-fresh.sh
