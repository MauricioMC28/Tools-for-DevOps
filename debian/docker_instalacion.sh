#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Ejecutar script como root"
    exit
fi

comando() {
    command -v "$1" >/dev/null 2>&1
}

directorio_keyrings="/etc/apt/keyrings"
asc_file="/etc/apt/keyrings/docker.asc"

if [ -d "$directorio_keyrings" ]; then
	echo "El directorio keyrings ya existe"
else
	echo "No se encontró el directorio $directorio_keyrings Creando..."
	sudo mkdir -p "$directorio_keyrings"
	sudo chmod 755 "$directorio_keyrings"
fi

if [ -f "$asc_file" ]; then
	echo "El archivo Docker.asc ya existe"
else
	sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
	sudo chmod a+r /etc/apt/keyrings/docker.asc
	echo \
	  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
	  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
	sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
fi

if ! comando docker; then
	for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
	echo "Instalando dependencias necesarias para Docker"
	sudo apt install -y apt-transport-https ca-certificates gnupg lsb-release
	sudo apt-get update -y
	sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	sudo groupadd docker
	sudo usermod -aG docker $USER
	sudo service docker start
	newgrp docker
else
	echo "Docker ya se encuentra instalado en el sistema"
fi
echo "Revisar: https://docs.docker.com/engine/install/linux-postinstall/ en caso de problemas"
docker -v
