#!/bin/bash

#Variables
kong_network="kong-net"
kong_imagen="kong:3.8.0"
kong_contenedor="kong-gateway"
kong_db_imagen="postgres:13-alpine3.19"
kong_db_contenedor="kong-database"

#Validacion de la imagen Kong
#if [ "$(docker images -q $kong_db_imagen && docker images -q $kong_imagen)" ]; then
#    echo "La imagen $kong_imagen ya existe"
#else
#    echo "Descargando imagen: $kong_imagen"
#    docker pull $kong_db_imagen && docker pull $kong_imagen
#fi

# Verifica si el contenedor de Base de Datos ya está corriendo
if [ "$(docker ps -q -f name=$kong_db_contenedor)" ]; then
    echo "El contenedor $kong_db_contenedor ya existe"
    docker container restart $kong_db_contenedor
else
    echo "Ejecutando el contenedor $kong_db_contenedor"
    docker run \
    --name $kong_db_contenedor \
    --restart=on-failure \
    --detach \
    --network $kong_network \
    --env POSTGRES_USER=kong \
    --env POSTGRES_DB=kong \
    --env POSTGRES_PASSWORD=kongpass \
    --publish 5432:5432 \
    $kong_db_imagen

    echo "Preparando la Base de Datos Kong"
    docker run \
    --rm --network $kong_network \
    --env KONG_DATABASE=postgres \
    --env KONG_PG_HOST=kong-database \
    --env KONG_PG_PASSWORD=kongpass \
    $kong_imagen kong migrations bootstrap
fi

if [ "$(docker ps -q -f name=$kong_contenedor)" ]; then
    echo "El contenedor $kong_contenedor ya existe"
    docker container restart $kong_contenedor
else
    echo "$kong_contenedor no existe, Iniciando el contenedor..."
    docker run \
    --name $kong_contenedor \
    --restart=on-failure \
    --detach \
    --network $kong_network \
    --env "KONG_DATABASE=postgres" \
    --env "KONG_PG_HOST=kong-database" \
    --env "KONG_PG_USER=kong" \
    --env "KONG_PG_PASSWORD=kongpass" \
    --env "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
    --env "KONG_ADMIN_ACCESS_LOG=/dev/stdout" \
    --env "KONG_PROXY_ERROR_LOG=/dev/stderr" \
    --env "KONG_ADMIN_ERROR_LOG=/dev/stderr" \
    --env "KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl" \
    --env "KONG_ADMIN_GUI_URL=http://localhost:8002" \
    --publish 8000:8000 \
    --publish 8002:8002 \
    --publish 8443:8443 \
    --publish 127.0.0.1:8001:8001 \
    --publish 127.0.0.1:8444:8444 \
    $kong_imagen
fi

