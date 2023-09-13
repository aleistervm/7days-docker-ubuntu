FROM ubuntu:22.04

LABEL maintainer="voxlltv@gmail.com"
LABEL version="1.0"
LABEL description="7 Days to Die Dedicated Server"

ENV ftp_username ftpuser
ENV ftp_password password

ENV volume_folder /gameserver

# Install requirements
# https://packages.ubuntu.com/focal/vsftpd
RUN apt install -y debconf libc6 libcap2 libpam-modules libpam0g libssl1.1 libwrap0 lsb-base netbase procps
RUN apt install -y ftp

# Install vsftpd
RUN apt install -y vsftpd

# Make sure vsftpd can be executed
RUN chmod +x /etc/init.d/vsftpd

# Create config directories
RUN mkdir -p /etc/vsftpd
RUN mkdir -p /etc/pam.d

# Overwrite default conf with ours
COPY ./config/vsftpd.conf       /etc/vsftpd.conf
COPY ./config/pam.d/vsftpd      /etc/pam.d/vsftpd

# Add FTP user
RUN useradd -m -s /bin/bash ${ftp_username}
RUN usermod -d ${volume_folder} ${ftp_username}
RUN echo "${ftp_username}:${ftp_password}" | chpasswd

# Add user as sudoer
RUN usermod -aG sudo ${ftp_username}

# Give the FTP user full access to server folder
RUN chmod -R u+rwx ${volume_folder} && chown -R ${ftp_username}:${ftp_username} ${volume_folder}

# Expose FTP
EXPOSE 20-21/tcp
EXPOSE 40000-50000/tcp

# Set the working directory to the server directory
WORKDIR ${volume_folder}

# Remove any files if this has run previously
RUN rm -rf /config/vsftpd

# Make directory for setup files
RUN mkdir -p /config/vsftpd

# Copy serverconfig.xml
COPY ./user.sh /config/vsftpd/user.sh

# Make the script file executable
RUN chmod +x /config/vsftpd/user.sh

ENTRYPOINT ["/config/vsftpd/user.sh"]
