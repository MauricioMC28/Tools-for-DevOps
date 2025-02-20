<h1 align='center'> Instalación de Jenkins en Docker</h1>

La siguiente instalación aprovecha al máximo el potencial de Jenkins version `2.462.3-1` y Docker version `27.3.1`.

- Docker CLI o Docker in Docker (dind)
- Permite utilizar los plugins y funciones de Blue Ocean

Para instalar correctamente Jenkins, sigue el siguiente orden de instalación:

1. Ingresa a la carpeta: 
	- `cd /Tools-for-DevOps/debian/jenkins_instalacion/`
2. Haz ejecutable los archivos `.sh` de este directorio con el comando: `chmod +x archivo.sh`.
3. Ejecuta el script de creacion de la red de Jenkins
	- `bash red-jenkins-docker.sh`
4. Seguidamente, el script de Dind
	- `bash dind-ejecucion.sh`
5. Y por último, el script de Jenkins
	- `bash jenkins-ejecucion.sh`

Utiliza el comando `docker ps` para revisar si jenkins se instalo correctamente, deberias ver UP en status.
```bash
CONTAINER ID   IMAGE                         COMMAND                  CREATED         STATUS         PORTS                                                                                      NAMES
6fe731a4bd3b   myjenkins-blueocean:2.492.1   "/usr/bin/tini -- /u…"   3 seconds ago   Up 3 seconds   0.0.0.0:8080->8080/tcp, :::8080->8080/tcp, 0.0.0.0:50000->50000/tcp, :::50000->50000/tcp   jenkins-blueocean
9c5af5f398e5   docker:dind                   "dockerd-entrypoint.…"   3 hours ago     Up 3 hours     2375/tcp, 0.0.0.0:2376->2376/tcp, :::2376->2376/tcp                                        jenkins-dind

```

Accede a jenkins con el siguiente URL: [jenkins](http://localhost:8080/)

- La contraseña maestra la puedes encontrar utilizando el siguiente comando:
	- `cat $HOME/myjenkins-startup-data/secrets/initialAdminPassword`
