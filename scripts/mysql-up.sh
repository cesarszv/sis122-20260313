#!/usr/bin/env bash
# LOGICA:
# El script levanta el contenedor de MySQL en el puerto 3307 local y asegura 
# que esté listo para aceptar conexiones antes de terminar su ejecución. 
# Si el contenedor ya existe pero no está corriendo, se limpia y recrea 
# para garantizar que la configuración (puertos, env, etc.) sea la correcta.
#
# PSEUDOCODIGO:
# 1. Definir variables (puerto local, versión, passwords, volumen).
# 2. Si el contenedor ya está corriendo en Docker:
#    a. Informar al usuario y salir (éxito).
# 3. Si el contenedor existe pero está detenido:
#    a. Borrarlo para que el siguiente 'docker run' sea limpio.
# 4. Iniciar el contenedor ('docker run') en segundo plano:
#    a. Mapear puerto 3307 -> 3306.
#    b. Montar volumen de datos para persistencia.
#    c. Configurar charset y collation de MySQL 8.x.
# 5. Entrar en un bucle de espera (hasta 60 intentos):
#    a. Usar 'mysqladmin ping' para verificar salud del servidor.
#    b. Si responde, informar éxito y salir.
#    c. Si no responde, esperar 2 segundos y reintentar.
# 6. Si el bucle falla por tiempo, mostrar error y sugerir revisar logs.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

if docker ps --format '{{.Names}}' | grep -Fxq "$CONTAINER_NAME"; then
  log_info "MySQL ya está levantado en 127.0.0.1:${MYSQL_PORT}."
  exit 0
fi

if docker ps -a --format '{{.Names}}' | grep -Fxq "$CONTAINER_NAME"; then
  log_warn "Contenedor $CONTAINER_NAME existe pero está detenido. Recreando..."
  docker rm -f "$CONTAINER_NAME" >/dev/null
fi

log_info "Iniciando MySQL ${MYSQL_VERSION} en puerto ${MYSQL_PORT}..."
docker run -d \
  --name "$CONTAINER_NAME" \
  --restart no \
  -p "${MYSQL_PORT}:3306" \
  -e MYSQL_ROOT_PASSWORD="$MYSQL_ROOT_PASSWORD" \
  -e MYSQL_DATABASE="$MYSQL_DATABASE" \
  -e MYSQL_USER="$MYSQL_USER" \
  -e MYSQL_PASSWORD="$MYSQL_PASSWORD" \
  -v "${VOLUME_NAME}:/var/lib/mysql" \
  mysql:${MYSQL_VERSION} \
  --skip-name-resolve=ON \
  --local_infile=0 \
  --character-set-server=utf8mb4 \
  --collation-server=utf8mb4_0900_ai_ci >/dev/null

log_info "Esperando a MySQL..."
for _ in {1..30}; do
  if docker exec "$CONTAINER_NAME" mysqladmin ping -h 127.0.0.1 -uroot -p"$MYSQL_ROOT_PASSWORD" --silent >/dev/null 2>&1; then
    log_success "MySQL listo en 127.0.0.1:${MYSQL_PORT}"
    exit 0
  fi
  sleep 1
done

log_error "MySQL no quedó listo a tiempo. Revisa: docker logs ${CONTAINER_NAME}" >&2
exit 1
