#!/bin/bash
ABS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source ${ABS_DIR}/remove-all-containers-vols-network.sh
source ${ABS_DIR}/remove-all-images.sh
source ${ABS_DIR}/reset-all-config-to-fresh.sh
