<h1 align='center'> Instalación de Jenkins en Docker</h1>

La siguiente instalación aprovecha al máximo el potencial de Jenkins version `2.462.3-1` y Docker version `27.3.1`.

- Docker CLI o Docker in Docker (dind)
- Permite utilizar los plugins y funciones de Blue Ocean

Para instalar correctamente Jenkins, sigue el siguiente orden de instalación:

1. Haz ejecutable los archivos `.sh` de este directorio con el comando: `chmod +x archivo.sh`.
2. Ejecuta el script de creacion de la red de Jenkins
3. Seguidamente, el script de Dind
4. Y por último, el script de Jenkins
