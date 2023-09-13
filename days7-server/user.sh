#!/bin/bash

# We are starting at /gameserver
ls -la

# Switch to Steam folder
cd /steam

# Install the 7 Days server from Steam
./steamcmd.sh +force_install_dir ../7days +login anonymous +app_update 294420 validate +quit

# Go back to server folder /gameserver
cd ..

# Copy the serverconfig template
cp ./config/7days/serverconfig.xml /7days

# Switch to the 7Days folder
cd /7days

# Log the start of the server
echo "$(date '+%Y-%m-%d %H:%M:%S') - Starting 7 Days to Die server..."

# Start the server
./startserver.sh -configfile=serverconfig.xml

# Log the server startup completion
echo "$(date '+%Y-%m-%d %H:%M:%S') - 7 Days to Die server has started."