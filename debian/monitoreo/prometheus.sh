#!/bin/bash

#Declaracion de variables
prometheus_imagen="prom/prometheus"
prometheus_contenedor="prometheus-docker"
prometheus_archivo="./myprometheus/prometheus.yml"

#Revisa si existe la imagen de prometheus
if [ ! "$(docker images -q $prometheus_imagen)" ]; then
    echo "Descargando imagen: $prometheus_imagen"
    docker pull $prometheus_imagen
else
    echo "Imagen $prometheus_imagen ya existe"
fi
#Revisa si existe el contenedor de Prometheus
if [ "$(docker ps -q -f name=$prometheus_contenedor)" ]; then
    echo "El contenedor $prometheus_contenedor ya existe"
else
    echo "Ejecutando el contenedor Docker $prometheus_contenedor"
    docker run \
    --name $prometheus_contenedor \
    --restart=on-failure \
    --detach \
    --publish 9090:9090 \
    --volume $prometheus_archivo:/etc/prometheus/prometheus.yml \
    --volume prometheus-data:/prometheus \
    $prometheus_imagen
fi
