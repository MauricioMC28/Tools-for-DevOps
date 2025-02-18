#!/bin/bash

check_netstat() {
	if command -v netstat &> /dev/null
	then
		echo "NetTools ya está instalado"
		netstat -V | grep net-tools
	else
		echo "NetTools no está instalado, instalando..."
		install_netstat
	fi
}

install_netstat() {
	#Actualiza el sistema
	sudo apt update

	#Investigar
	#echo "nameserver 8.8.8.8" > /etc/resolv.conf

	#Instala la herramienta netstat
	apt install net-tools

	echo "NetTools ha sido instalado"
	netstat -V | grep net-tools
}

echo "Revisando si NetTools está instalado en el Sistema"
check_netstat
