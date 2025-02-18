
#!/bin/bash

if [ "$EUID"-ne 0 ]; then
    echo "Ejecutar script como root"
    exit
fi

comando() {
    command -v "$1" >/dev/null 2>&1
}

ansible_keyring="/usr/share/keyrings/ansible-archive-keyring.gpg"
#sudo rm /etc/apt/sources.list.d/ansible.list

if [ -f "$ansible_keyring" ]; then
    echo "El archivo $ansible_keyring ya existe."
else
    echo "El archivo $ansible_keyring no se encontró. Instalando..."
    wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | sudo gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/ansible.list

    if [ $? -eq 0 ]; then
        echo "Archivo descargado exitosamente."
    else
        echo "Error al descargar el archivo."
    fi
fi

if ! comando ansible; then
	sudo apt update -y && sudo apt install ansible
else
	echo "Ansible ya se encuentra instalado en el sistema"
fi

ansible --version | head -n 1
