#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Ejecutar script como root"
    exit
fi

comando() {
    command -v "$1" >/dev/null 2>&1
}

### Instalación de Terraform
terraform_keyrings="/usr/share/keyrings/hashicorp-archive-keyring.gpg"
if [ -f "$terraform_keyrings" ]; then
    echo "El archivo $terraform_keyrings ya existe"
else
    echo "El archivo $terraform_keyrings no se encontró. Instalando"
    wget -O- https://apt.releases.hashicorp.com/gpg | \
	gpg --dearmor | \
	sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
	echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
	https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
	sudo tee /etc/apt/sources.list.d/hashicorp.list

    if [ $? -eq 0 ]; then
        echo "Archivo descargado exitosamente."
    else
        echo "Error al descargar el archivo."
    fi
fi

if ! comando terraform; then
	sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
	sudo apt update -y
	sudo apt-get install terraform
else
	echo "Terraform ya se encuentra instalado en el sistema"
fi

terraform -v | head -n 1
