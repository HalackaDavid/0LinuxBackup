####################
### DOCKER SETUP ###
####################

PRESETUP
https://docs.docker.com/desktop/setup/install/linux/

MAKING IT WORK
https://wiki.archlinux.org/title/Docker
https://github.com/moby/moby/issues/38373#issuecomment-447393517
https://wiki.archlinux.org/title/Help:Reading#Control_of_systemd_units
https://stackoverflow.com/questions/44678725/cannot-connect-to-the-docker-daemon-at-unix-var-run-docker-sock-is-the-docker
https://www.hostinger.com/tutorials/how-to-fix-docker-permission-denied-error?utm_campaign=Generic-Tutorials-DSA-t1|NT:Se|LO:Other-EU&utm_medium=ppc&gad_source=1&gad_campaignid=12231291749&gclid=EAIaIQobChMIz8-J-vPIkAMVC5SDBx3MKhFNEAAYASAAEgJmFfD_BwE

sudo pacman -S docker

docker info
systemctl start docker.sock
systemclt enable docker.socket
systemclt enable docker.sock
systemclt enable docker.socket
systemctl enable docker.socket
docker info
systemctl enable docker.sock
docker info
systemctl start docker
docker info
ll /var/run/docker.sock

#Creating new group called docker
sudo usermod -aG docker $USER
newgrp docker


https://www.youtube.com/watch?v=cWMztQwIQNs
https://www.youtube.com/watch?v=pg19Z8LL06w


#######################
### DOCKER COMMANDS ###
#######################
docker start [container ID]
docker stop [container ID]
docker restart [container ID] or [container NAME]

docker logs [container ID] (container ID -> docker ps)


#################
# DOCKER IMAGES #
#################
docker images -> Show images


#############
# DOCKER PS #
#############
docker ps -> Show docker containers

    -a -> list stopped and running containers

###########################
# DOCKER REMOVE CONTAINER #
###########################
docker rm [container NAME]

###############
# DOCKER PULL #
###############
docker pull [x]:tag -> Fetch [x]:tag docker image from docker hub
                    -> Without tag >> docker pull [x] -> will fetch lates version
                    -> nginx:1.23


##############
# DOCKER RUN #
##############
docker run [x]:tag -> run in front

[Info] docker run without tag will create latest image; if not downloaded it will do so then it will run it


    -d run in background (-d or --detach >> run it in background)


    -p [HOST_PORT]:[CONTAINER_PORT]

    --name --> give container custom name rather then random name


#############################
### CREATING DOCKER IMAGE ###
#############################

docker build <dest of docker file>
-t -> [x}:tag (server:1.0)


Dockerfile -> Image -> Container

# BLUEPRINT #
```
FROM

COPY <src> <dest>

WORKDIR <dest>

RUN

CMD [  ]
```


# TEST PROJ #
MainDir
|
-> src/
|    |
|    -> main.js
|    -> other.js
|
-> file.json
```
FROM node:19-alpine

COPY src /app/
COPY file.json /app/

WORKDIR /app

RUN npm install

CMD ["node", "main.js"]
```

