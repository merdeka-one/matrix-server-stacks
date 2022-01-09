#!/bin/bash
ABS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
#ROOT_DIR="$(dirname "$ABS_DIR" )"
ROOT_DIR="$(echo "$ABS_DIR" )"
SCRIPTS_DIR="$(echo ${ROOT_DIR}/bash-scripts)"

nano ${SCRIPTS_DIR}/bash_user_data_simple
