#!/bin/bash

#Variables
jenkins_network="jenkins"
dind_imagen="docker:dind"
dind_contenedor="jenkins-dind"

#Validacion de la imagen DIND
if [ ! "$(docker images -q $dind_imagen)" ]; then
  echo "Downloading image: $dind_imagen"
  docker pull $dind_imagen
else
  echo "Image $dind_imagen already exists"
fi

#Validación del contenedor DIND
if [ "$(docker ps -q -f name=$dind_contenedor)" ]; then
    echo "Container $dind_contenedor is already running"
else
    echo "Running Docker container $dind_contenedor"
    docker run \
    --name $dind_contenedor \
    --rm \
    --detach \
    --privileged \
    --network $jenkins_network \
    --network-alias docker \
    --env DOCKER_TLS_CERTDIR=/certs \
    --volume jenkins-docker-certs:/certs/client \
    --volume jenkins-data:/var/jenkins_home \
    --publish 2376:2376 \
    $dind_imagen \
    dockerd -H tcp://0.0.0.0:2375 \
    --storage-driver overlay2
fi
