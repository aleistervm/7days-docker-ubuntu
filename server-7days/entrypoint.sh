#!/bin/bash
set -e

# --- Initial Setup (Only runs once) ---
if [ ! -f "${SERVER_DIR}/7DaysToDieServer.x86_64" ]; then
    echo "Installing 7 Days to Die Server for the first time..."
    /steamcmd/steamcmd.sh +@sSteamCmdForcePlatformType linux +login anonymous +force_install_dir ${SERVER_DIR} +app_update 294420 validate +quit
fi

# Function to handle shutdown signals
term_handler() {
    echo "Caught TERM signal, shutting down server..."
    kill -TERM "$SERVER_PID"
    wait "$SERVER_PID" # Wait for the server to truly stop
    exit 0
}

# Trap TERM and INT signals to call our term_handler function
trap 'term_handler' TERM INT

# --- Main Server Loop ---
while true; do
    # On first run of the loop, check and seed the config
    if [ ! -f "${DATA_DIR}/serverconfig.xml" ]; then
        echo "serverconfig.xml not found in /data. Seeding from template."
        mv /tmp/serverconfig.xml ${DATA_DIR}/serverconfig.xml
    fi

    echo "Starting 7 Days to Die Server from config in /data volume..."
    
    # Start the server in the background
    ./7DaysToDieServer.x86_64 \
        -logfile /dev/stdout \
        -quit \
        -configfile=${DATA_DIR}/serverconfig.xml \
        -dedicated \
        -batchmode \
        -nographics &

    SERVER_PID=$!
    
    # Wait for the server process. If it's killed, the loop will restart it.
    wait $SERVER_PID
    
    # If the process exits, wait a moment before restarting to prevent rapid-fire failures
    echo "Server process stopped. Restarting in 5 seconds..."
    sleep 5
done
