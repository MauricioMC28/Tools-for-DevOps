#!/bin/bash

#Variables
jenkins_network="jenkins"
jenkins_image="myjenkins-blueocean:2.492.1"
jenkins_contenedor="jenkins-blueocean"
jenkins_directorio="$HOME/myjenkins-startup-data"

#Directorio para Jenkins
mkdir -p "$jenkins_directorio"
sudo chown -R $USER:$USER "$jenkins_directorio"

# Construir la imagen de Jenkins personalizada
docker build -t $jenkins_image .

# Verifica si el contenedor ya está corriendo
if [ "$(docker ps -q -f name=$jenkins_contenedor)" ]; then
  echo "Container $jenkins_contenedor is already running"
else
    echo "Running Jenkins container $jenkins_contenedor"
    docker run \
    --name $jenkins_contenedor \
    --restart=on-failure \
    --detach \
    --network $jenkins_network \
    --env DOCKER_HOST=tcp://docker:2376 \
    --env DOCKER_CERT_PATH=/certs/client \
    --env DOCKER_TLS_VERIFY=1 \
    --publish 8080:8080 \
    --publish 50000:50000 \
    --volume $jenkins_directorio:/var/jenkins_home \
    --volume jenkins-docker-certs:/certs/client:ro \
    $jenkins_image
fi
