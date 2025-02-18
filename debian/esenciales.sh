#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Ejecutar script como root"
    exit
fi

comando() {
    command -v "$1" >/dev/null 2>&1
}

###Instalación de dependencias esenciales de Debian

echo "Revisando Essential en el sistema"
if ! comando build-essential; then
	sudo apt install -y build-essential
else
	echo "Essential ya se encuentra instalado en el sistema"
fi

echo "Instalando Curl en el sistema"
if ! comando curl; then
    sudo apt install -y curl
else
    echo "Curl ya se encuentra instalado en el sistema"
fi

echo "Instalando GNUP en el sistema"
if ! comando gnupg; then
    sudo apt-get install -y apt-transport-https ca-certificates gnupg
else
    echo "gnupg ya se encuentra instalado en el sistema"
fi

echo "Instalando wget en el sistema"
if ! comando wget; then
	sudo apt install -y wget
else
	echo "Wget ya se encuentra instalado en el sistema"
fi

### Instalación de Git

echo "Instalando GIT en el sistema"
if ! comando git; then
	sudo apt install -y git
else
	echo "Git ya se encuentra instalado en el sistema"
fi

curl --version | head -n 1 | awk '{print $1,$2}'
python3 --version
gpg --version | head -n 1
wget --version | head -n 1
git --version
