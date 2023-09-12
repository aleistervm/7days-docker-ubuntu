#!/bin/bash

# Switch to /gameserver
cd /gameserver || exit

# Start a screen session named "7days-server"
screen -dmS 7days-server

# Attach to the screen session
screen -S 7days-server -X stuff $'./steamcmd.sh +force_install_dir /7days +login anonymous +app_update 294420 validate +quit\n'
screen -S 7days-server -X stuff $'cp serverconfig.xml /7days\n'
screen -S 7days-server -X stuff $'cd /7days\n'
screen -S 7days-server -X stuff $'./startserver.sh -configfile=serverconfig.xml\n'

# Detach from the screen session
screen -S 7days-server -X detach