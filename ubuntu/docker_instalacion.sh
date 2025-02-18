#!/bin/bash

check_docker() {
	if command -v docker &> /dev/null
	then
		echo "Docker ya esta instalado"
		docker --version
	else
		echo "Docker no está instalado. Instalando..."
		install_docker
	fi
}


install_docker() {

	#Eliminar librerias en conflicto
	for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc;
	do
		sudo apt-get remove $pkg;
	done

	#Agrega la llave GPG oficial de Docker:
	sudo apt-get install ca-certificates curl gnupg
	sudo install -m 0755 -d /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	sudo chmod a+r /etc/apt/keyrings/docker.gpg

	#Agrega el repositorio a la fuente Apt:
	echo \
		"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
		$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
		sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt-get update

	#---------------Instalación de la ultima version----------------
       #Borrar el #	
	#sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

	#--------------------Instala una version especifica-------------
	#Listar versiones disponibles
	apt-cache madison docker-ce | awk '{ print $3 }'
	sudo apt-get install -y docker-ce=$VERSION_STRING docker-ce-cli=$VERSION_STRING containerd.io docker-buildx-plugin docker-compose-plugin

	#Crea grupo de Docker y agrega Usuario
	sudo groupadd docker
	sudo usermod -aG docker $USER
	newgrp docker
	sudo systemctl restart docker
	sudo systemctl enable docker.service
	sudo systemctl enable containerd.service

	echo "Docker ha sido instalado correctamente"
	docker --version
}

echo "Revisar si Docker esta instalado"
check_docker

