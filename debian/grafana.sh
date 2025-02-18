#!/bin/bash

#Variables
grafana_imagen="grafana/grafana-enterprise:11.2.2"
grafana_contenedor="grafana"
grafana_directorio="$HOME/grafana"

#Directorio
mkdir -p "$grafana_directorio"
sudo chown -R $USER:USER "grafana_directorio"

#Validación de imagen
if [ ! "$(docker images -q $grafana_imagen)" ]; then
    echo "Descargando imagen: $grafana_imagen"
    docker pull $grafana_imagen
else
    echo "Imagen $grafana_imagen ya existe"
fi

#Validación de contenedor
if [ "$(docker ps -q -f name=$grafana_contenedor)" ]; then
    echo "El contenedor $grafana_contenedor ya existe"
else
    echo "Ejecutando el contenedor Docker $grafana_contenedor"
    docker run \
    --name $grafana_contenedor \
    --restart=on-failure \
    --detach \
    --publish 3000:3000 \
    --user "$(id -u)" \
    --volume $grafana_directorio:/var/lib/grafana \
    -e "GF_LOG_LEVEL=debug" \
    -e "GF_INSTALL_PLUGINS=grafana-clock-panel, grafana-simple-json-datasource" \
    $grafana_imagen
fi
