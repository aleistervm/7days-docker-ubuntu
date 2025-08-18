FROM ubuntu:22.04

LABEL maintainer="voxlltv@gmail.com"
LABEL version="1.0"
LABEL description="7 Days to Die Dedicated Server"

ENV SERVER_DIR /home/steam/7DTD
ENV DATA_DIR /data 
ENV STEAMCMD_DIR /steamcmd

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

# Create a 'steam' user for better security
RUN useradd --create-home --shell /bin/bash steam

# Install required packages
RUN dpkg --add-architecture i386 && \
    apt update \
    && apt install -y --no-install-recommends \
        ca-certificates \
        curl \
        wget \
        tar \
        lib32gcc-s1 \
        lib32stdc++6 \
        libstdc++6 \
        libstdc++6:i386 \
        libsdl2-2.0-0:i386 \
    && rm -rf /var/lib/apt/lists/*

# Create the SteamCMD directory and download/extract SteamCMD
RUN mkdir -p ${STEAMCMD_DIR} && \
    curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar -C ${STEAMCMD_DIR} -zxvf -

# Create server/data directories and set permissions
RUN mkdir -p ${SERVER_DIR} ${DATA_DIR} && \
    chown -R steam:steam /home/steam ${DATA_DIR} ${STEAMCMD_DIR}

# Switch to steam user
USER steam

# Set the working directory to the server directory
WORKDIR ${server_folder}

# Copy the entrypoint script and make it executable
COPY --chown=steam:steam entrypoint.sh .
COPY --chown=steam:steam serverconfig.xml /tmp/serverconfig.xml

RUN chmod +x entrypoint.sh

# Expose game ports
EXPOSE 26900-26903/tcp
EXPOSE 26900-26903/udp
EXPOSE 8080-8082/tcp

# Prompt for user input
ENTRYPOINT ["./entrypoint.sh"]
