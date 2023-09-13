#!/bin/bash

echo "Installing 7 Days to Die Dedicated Server..."

# Start a detached screen session named "7days-install" and run the installation script within it.
#screen -dmS 7days-install sh ./d7_server_install.sh
sh ./d7_server_install.sh

echo "Installation started. If you connect to the Docker container, you can reattach to the screen session with: screen -r 7days-install"

# Wait for the screen session to finish
#while screen -list | grep -q "7days-install"; do
#  sleep 1
#done

#echo "Installation completed. Exiting."