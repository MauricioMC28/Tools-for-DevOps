#!/bin/bash

check_sysstat() {
        if command -v sysstat &> /dev/null
        then
                echo "mpstat ya está instalado"
                mpstat -V | grep version
        else
                echo "sysstat no está instalado, instalando..."
                install_sysstat
        fi
}

install_sysstat() {
        #Actualiza el sistema
        sudo apt update

        #Investigar
        #echo "nameserver 8.8.8.8" > /etc/resolv.conf

        #Instala la herramienta netstat
        apt install sysstat

        echo "Sysstat/mpstat ha sido instalado"
        mpstat -V | grep version
}

echo "Revisando si mpstat está instalado en el Sistema"
check_sysstat
