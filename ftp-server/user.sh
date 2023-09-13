#!/bin/bash

echo "Starting vsftpd..."

# Start the FTP server
# /etc/init.d/vsftpd start
/usr/sbin/vsftpd /etc/vsftpd.conf

# Check the exit status of the previous command
if [ $? -ne 0 ]
then
  # An error occurred, so let's check the logs
  echo "vsftpd failed to start. Checking logs..."

  # To view the vsftpd logs
  cat /var/log/vsftpd.log
fi
