FROM ubuntu:22.04

LABEL maintainer="voxlltv@gmail.com"
LABEL version="1.0"
LABEL description="7 Days to Die Dedicated Server"

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

ENV volume_folder       /gameserver
ENV steam_folder        /gameserver/steam
ENV days7_folder        /gameserver/7days

RUN apt update
RUN apt install -y screen nano curl wget git bzip2 gzip unzip net-tools

# Install libraries required by game
RUN dpkg --add-architecture i386 && \
    apt update && \
    apt install -y lib32gcc-s1 lib32stdc++6 libstdc++6 libstdc++6:i386 libsdl2-2.0-0:i386

# Create the server folder
RUN mkdir -p ${days7_folder}

# Download and extract SteamCMD
RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - -C ${steam_folder}

# Expose game ports
EXPOSE 26900-26903/tcp
EXPOSE 26900-26903/udp
EXPOSE 8080-8082/tcp

# Set the working directory to the server directory
WORKDIR ${volume_folder}

# Remove any files if this has run previously
RUN rm -rf /config/7days

# Make directory for setup files
RUN mkdir -p /config/7days

# Copy serverconfig.xml
COPY ./config/serverconfig.xml  /config/7days/serverconfig.xml
COPY ./user.sh                  /config/7days/user.sh

# Make the script file executable
RUN chmod +x /config/7days/user.sh

ENTRYPOINT ["/config/7days/user.sh"]