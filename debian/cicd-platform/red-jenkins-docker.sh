#!/bin/bash

# Variable
network_name="jenkins"

#validación de red
if [ ! "$(docker network ls | grep $network_name)" ]; then
  echo "Creating Docker bridge network: $network_name"
  docker network create $network_name
else
  echo "Network $network_name already exists"
fi
