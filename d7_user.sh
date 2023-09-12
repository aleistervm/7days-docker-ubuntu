#!/bin/bash

while true; do
    read -p "Do you wish to install the 7 Days to Die Dedicated Server? " yn
    case $yn in
        [Yy]* ) ./d7_server_install.sh; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done