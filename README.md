# Ubuntu 7 Days to Die Server

## Included Features
1. The Dockerfile creates a fresh 7 Days to Die server and stores the game save in a Docker `volume`.
2. An FTP server is also setup so you can upload files/mods to the 7 Days server.

## How To Run the Server

### Create the Docker volume
The Docker volume will contain your server's data and saved game.
```
docker volume create my_7days_server
```

### Build
Build the docker image.<br/>
This line must be run in the folder where the Dockerfile is located.
```
docker build -t 7days-server:latest .
```

### Run
Run the docker container with a volume. <br/>
NOTE: The `/gameserver` below must match the `server_folder` defined in the `Dockerfile`.
```
docker run -d --name 7days-server \
  -p 26900-26903:26900-26903/tcp \
  -p 26900-26903:26900-26903/udp \
  -p 8080-8082:8080-8082/tcp \
  -p 20-21:20-21/tcp \
  -p 40000-50000:40000-50000/tcp \
  -v my_7days_server:/gameserver \
  7days-server:latest
```

### Optional: Check on the container
If you need to connect to the container, use the following command:
```
docker exec -it 7days-server /bin/bash
```


## Exposing Ports

### Ports
If you have not modified the provided `serverconfig.xml` or `vsftpd.conf`, these ports need to be open:
- 26900 - 26903 (TCP & UDP)
- 8080 - 8082 (TCP)
- 20 - 21 (TCP)
- 40000 - 50000 (TCP)

### Local Machine
If you are running this 7 Days Dedicated Docker server on a computer at your home, you need to
forward the ports mentioned above in your router.<br/>
https://www.lifewire.com/how-to-port-forward-4163829

### AWS / Azure / Other hosting service
If you are hosting in AWS or Azure, be sure to open the ports in a security group.

### Windows Defender firewall
If hosting on a Windows device, be sure to open the ports in Windows firewall.<br/>
https://www.tomshardware.com/news/how-to-open-firewall-ports-in-windows-10,36451.html

### Ubuntu firewall
Ubuntu's firewall configuration tool, `ufw`, is _not_ enabled by default. However, if you want to enable it,
you can do so with the following command:
```
sudo ufw enable
```
For more details, please see the Ubuntu docs:<br/>
https://ubuntu.com/server/docs/security-firewall


## Notes

### A. Where are Docker volumes stored?
Windows:
```
\\wsl$\docker-desktop-data\data\docker\volumes
```
Ubuntu:
```
/var/lib/docker/volumes
```

### B. Will this run on Windows? Mac? Linux?
Yes. This server will run on any OS that can run Docker.
<br/>

### C. How do I setup an Ubuntu 22.04 server with Docker?
Check out `server-config.sh`. Everything you need to run the 7 Days Dedicated Server docker image on an Ubuntu machine is included.
<br/>

### D. How do I backup my save game?
Docker volumes are _not_ something you can copy/paste. Please refer to the Docker documentation:<br/>
https://docs.docker.com/storage/volumes/#back-up-restore-or-migrate-data-volumes