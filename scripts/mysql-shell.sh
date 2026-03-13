#!/usr/bin/env bash
# LOGICA:
# El script abre una sesión de terminal interactiva (tty) dentro del contenedor 
# para que el usuario pueda escribir comandos SQL de forma manual.
#
# PSEUDOCODIGO:
# 1. Definir credenciales de acceso a MySQL.
# 2. Entrar al contenedor ('docker exec') en modo interactivo y con terminal.
# 3. Invocar al ejecutable 'mysql' dentro del contenedor para conectar a la BD.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

log_info "Entrando a la consola interactiva de MySQL (${MYSQL_DATABASE})..."
log_info "Escribe 'exit' para salir."

docker exec -it "$CONTAINER_NAME" mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE"
