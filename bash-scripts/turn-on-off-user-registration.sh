#!/bin/bash

source bash_data
if [ '$1' == 'off' ]; then
    HS_ENABLE_REGISTRATION='false'
fi

sudo sed  "s/enable_registration:.*/enable_registration: ${HS_ENABLE_REGISTRATION}/" $(sudo find /var/lib/docker/volumes/${DIR}_data-synapse/  -name homeserver.yaml)


#perl -pi -e 's/as_token:.*/as_token: "$ENV{TEMP}"/' ${MAUTRIX_TELEGRAM_LOCAL_FOLDER}config.yaml-${FINAL_RC}


