#!/bin/bash

# Copy the files from Steam
./steamcmd.sh +force_install_dir /7days +login anonymous +app_update 294420 validate +quit

# Copy the serverconfig template
cp serverconfig.xml /7days

# Switch to the folder
cd /7days || quit

# Start the server
./startserver.sh -configfile=serverconfig.xml
