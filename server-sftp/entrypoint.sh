#!/bin/sh

# Exit immediately if a command exits with a non-zero status.
set -e

# Set default values for environment variables if they are not provided
SFTP_USER=${SFTP_USER:-user}
SFTP_PASS=${SFTP_PASS:-pass}
USER_ID=${SFTP_UID:-1000}
GROUP_ID=${SFTP_GID:-1000}

# Create a group and user for SFTP access using Ubuntu's commands
echo "Creating SFTP user '${SFTP_USER}' with UID ${USER_ID} and GID ${GROUP_ID}"
groupadd -g ${GROUP_ID} ${SFTP_USER}
useradd -l -u ${USER_ID} -g ${SFTP_USER} -d /home/${SFTP_USER} -s /sbin/nologin ${SFTP_USER}

# Set the password for the new user (this command is the same)
echo "${SFTP_USER}:${SFTP_PASS}" | chpasswd

# Create the directories for the volumes inside the user's home
mkdir -p /home/${SFTP_USER}/data

# Change ownership of the home directory (this command is the same)
chown -R ${SFTP_USER}:${SFTP_USER} /home/${SFTP_USER}

echo "SFTP user created. Starting SSH daemon..."

# This command executes the CMD from the Dockerfile (starts the sshd server)
exec "$@"
