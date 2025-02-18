#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Ejecutar script como root"
    exit
fi

comando() {
    command -v "$1" >/dev/null 2>&1
}

### Instalación de minikube (Kubernetes)

echo "Instalando Kubectl en el sistema"
if ! comando kubectl; then
    echo "Instalando el binario de Kubectl con Curl en el sistema"
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/bin/kubectl
else
    echo "Kubectl ya se encuentra instalado en el sistema"
fi

echo "Instalando minikube en el sistema"
if ! comando minikube; then
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
	sudo dpkg -i minikube_latest_amd64.deb
    sudo usermod -aG docker $USER && newgrp docker
	minikube start
    sudo rm -r minikube_latest_amd64.deb
else
    echo "minikube ya se encuentra instalado en el sistema"
fi

kubectl version --client
minikube version | head -n 1
