<h1 align="center"> Configura tu propio dominio Local</h1>

<p align=center>Esta configuracion permite llamar a un servidor externo por medio de un dominio personalizado localmente, es decir, si llamas al servidor1 como local.local, solamente tu puedes llamar al servidor por medio de ese nombre, los demás, deben llamarlo por servidor1, hasta que realicen esta misma configuración dentro de su dispositivo</p>

Edita el archivo hosts que se encuentra en el siguiente directorio:

```cmd
C:\Windows\System32\drivers\etc
```
Requerimientos:
- IP del servidor local.
- Permisos

Agrega la siguiente linea dentro del archivo hosts:

```
	IP-del-servidor       dominio-personalizado
```

> [!TIP]
> Ejemplo:
>
> 	172.25.48.169       maycloud.local

