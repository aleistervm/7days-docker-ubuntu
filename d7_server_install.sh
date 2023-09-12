#!/bin/bash

# Redirect standard output and standard error to log files
# Monitor logs with: docker exec -it 7days-server tail -f /gameserver/install_7days.log
exec >> install_7days.log 2>&1

# Start the FTP server
sudo systemctl enable vsftpd
sudo systemctl start vsftpd

# Install the 7 Days server from Steam
./steamcmd.sh +force_install_dir /7days +login anonymous +app_update 294420 validate +quit

# Copy the serverconfig template
cp serverconfig.xml /7days

# Switch to the folder
cd /7days || exit

# Log the start of the server
echo "$(date '+%Y-%m-%d %H:%M:%S') - Starting 7 Days to Die server..."

# Start the server
./startserver.sh -configfile=serverconfig.xml

# Log the server startup completion
echo "$(date '+%Y-%m-%d %H:%M:%S') - 7 Days to Die server has started."
