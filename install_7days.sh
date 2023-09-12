#!/bin/bash

# Switch to /gameserver
cd /gameserver || exit

# Create or update the 7 Days to Die server files in the mounted volume
./steamcmd.sh +force_install_dir /7days +login anonymous +app_update 294420 validate +quit

# Copy in our pre-defined server config
cp serverconfig.xml /7days

# Switch to /gameserver/7days
cd /7days || exit

# Start your server
screen -dmS days7server ./startserver.sh -configfile=serverconfig.xml