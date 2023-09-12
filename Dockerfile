FROM ubuntu:22.04

LABEL maintainer="voxlltv@gmail.com"
LABEL version="1.0"
LABEL description="7 Days to Die Dedicated Server"

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

# Update Ubuntu Software repository
RUN apt update

ENV vsftpd_conf /etc/vsftpd.conf

ENV ftp_username ftpuser
ENV ftp_password password

ENV server_folder /gameserver
ENV days7_folder /gameserver/7days

RUN apt-get update
RUN apt-get install -y screen nano curl wget git bzip2 gzip unzip

# Install networking tools
RUN apt-get install -y vsftpd
COPY /config/vsftpd.conf /etc/vsftpd.conf

# Add FTP user
RUN useradd -m -s /bin/bash ${ftp_username}
RUN usermod -d ${server_folder} ${ftp_username}
RUN echo "${ftp_username}:${ftp_password}" | chpasswd

# Install libraries required by game
RUN dpkg --add-architecture i386 && \
    apt update && \
    apt install -y lib32gcc-s1 lib32stdc++6 libstdc++6 libstdc++6:i386 libsdl2-2.0-0:i386

# Create the server folder
RUN mkdir -p ${days7_folder}

# Give the user full access to this folder
RUN chmod -R u+rwx ${server_folder} && chown -R ${ftp_username}:${ftp_username} ${server_folder}

# Switch to the newly created user
USER ${ftp_username}

# Install SteamCMD
RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - -C ${server_folder}

# Install 7 Days to Die
RUN ${server_folder}/steamcmd.sh +force_install_dir ${days7_folder} +login anonymous +app_update 294420 validate +quit

# Expose game ports
EXPOSE 26900-26903/tcp
EXPOSE 26900-26903/udp
EXPOSE 8080-8082/tcp

# Expose FTP
EXPOSE 20-21/tcp
EXPOSE 40000-50000/tcp

# Set the working directory to the server directory
WORKDIR ${server_folder}

# Copy serverconfig.xml
COPY /config/serverconfig.xml ./serverconfig.xml
COPY d7_user.sh ./d7_user.sh
COPY d7_server_install.sh ./d7_server_install.sh

# Prompt for user input
CMD ["./d7_user.sh"]