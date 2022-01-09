#!/bin/bash

if [ "$(grep -Ei 'debian|buntu|mint' /etc/*release)" ]; then
    sudo apt-get install ufw

    sudo ufw allow ssh
    sudo ufw allow http
    sudo ufw allow https
    sudo ufw allow 81/tcp
    sudo ufw allow 8443/tcp

    sudo ufw enable
fi
