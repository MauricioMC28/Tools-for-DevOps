# Instalar Nodejs 23 en Debian 12

Proceso de instalación de NodeJS para Debian 12, WSL2
## Material de apoyo

Enlace directo: <a href="https://github.com/nodesource/distributions">NodeSource para Linux</a>

## Proceso
Instala la herramienta Curl

```
sudo apt-get install -y curl
```
Descarga la distribucion de node y el script de instalacion:

```
curl -fsSL https://deb.nodesource.com/setup_23.x -o nodesource_setup.sh
```
Haz ejecutable el script

```
chmod +x nodesource_setup.sh
```
Ejecuta el script instalador

```
sudo bash nodesource_setup.sh
```

Instala Nodejs:

```
sudo apt-get install nodejs -y
```

Verifica la instalacion:

```
node -v
```
