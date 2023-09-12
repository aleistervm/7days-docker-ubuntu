# Ubuntu 7 Days to Die Server

### Included Features
1. The Dockerfile creates a fresh 7 Days to Die server and stores the game save in a Docker `volume`.
2. An FTP server is also setup so you can upload files/mods to the 7 Days server.
<br/>
<br/>

### Basics
Run the following commands in the same directory as the Dockerfile.
<br/><br/>

### Create the save folder
Create a volume:
```
docker volume create my_7days_server
```
<br/>

### Build
Build the docker image:
```
docker build -t 7days-server:latest .
```
<br/>

### Run
Run the docker container with a volume. <br/>
NOTE: The /gameserver below must match the `server_folder` defined in the `Dockerfile`.
```
docker run -itd --name 7days-server \
  -p 26900-26903:26900-26903/tcp \
  -p 26900-26903:26900-26903/udp \
  -p 8080-8082:8080-8082/tcp \
  -p 20-21:20-21/tcp \
  -v my_7days_server:/gameserver \
  7days-server:latest
```
<br/>

### Notes
On Ubuntu, volumes are stored here by default:
```
/var/lib/docker/volumes
```
<br/>