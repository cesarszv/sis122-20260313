# MySQL 8.4.8 LTS local bajo demanda

## Flujo recomendado

Primero entra al directorio de la entrega:

```bash
cd assignments/20260313
```

1. Levantar MySQL:

```bash
./scripts/mysql-up.sh
```

2. Crear la base `sis122-20260312` y cargar esquema + inserts:

```bash
./scripts/mysql-reset-and-load.sh
```

3. Verificar consultas:

```bash
./scripts/mysql-verify.sh
```

4. Abrir shell SQL:

```bash
./scripts/mysql-shell.sh
```

5. Parar el contenedor cuando termines:

```bash
./scripts/mysql-down.sh
```

6. Borrar todo, incluyendo datos:

```bash
./scripts/mysql-destroy.sh
```

## DataGrip

- Version fijada: `MySQL Community Server 8.4.8 LTS`
- Host: `127.0.0.1`
- Port: `3307`
- User: `sis122`
- Password: `sis122_local_dev`
- Database: ``sis122-20260312``
- Authentication: `User & Password`
- SSL: `No`
- JDBC URL: `jdbc:mysql://127.0.0.1:3307/sis122-20260312?useSSL=false&allowPublicKeyRetrieval=true&connectTimeout=5000&socketTimeout=10000`

## Buenas practicas aplicadas

- Version de imagen fijada a `8.4.8` para evitar cambios sorpresa por tags flotantes.
- `restart: "no"` para que no quede nada resucitando solo despues.
- `skip-name-resolve=ON` para evitar demoras raras por DNS inverso en conexiones locales.
- `local_infile=0` para reducir superficie innecesaria en un entorno de tarea.
- Autenticacion `caching_sha2_password`, que es la recomendada en MySQL 8.

## Si una inicializacion vieja quedo rota

Si alguna vez intentaste levantar otro contenedor MySQL 8.4.8 con opciones invalidas y el volumen quedo a medio inicializar, limpia todo y vuelve a empezar:

```bash
./scripts/mysql-destroy.sh
./scripts/mysql-up.sh
```
