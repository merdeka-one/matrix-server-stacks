#!/bin/bash
ABS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
#ROOT_DIR="$(dirname "$ABS_DIR" )"
ROOT_DIR="$(echo "$ABS_DIR" )"
SCRIPTS_DIR="$(echo ${ROOT_DIR}/bash-scripts)"

source ${SCRIPTS_DIR}/run-0-matrix.sh

source ${SCRIPTS_DIR}/run-1st-matrix.sh

source ${SCRIPTS_DIR}/run-2nd-matrix.sh

sleep 10s

source ${SCRIPTS_DIR}/run-3rd-matrix.sh

source ${SCRIPTS_DIR}/run-4th-matrix.sh

sleep 10s

source ${SCRIPTS_DIR}/run-5th-matrix.sh

sleep 10s

source ${SCRIPTS_DIR}/run-6th-matrix.sh

