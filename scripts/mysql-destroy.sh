#!/usr/bin/env bash
# LOGICA:
# El script se encarga de realizar una limpieza total del entorno.
# Primero identifica si el contenedor existe para borrarlo, y luego
# hace lo mismo con el volumen de persistencia para asegurar un estado limpio.
#
# PSEUDOCODIGO:
# 1. Definir nombres del contenedor y volumen.
# 2. Si el contenedor existe (activo o no):
#    a. Forzar su eliminación (docker rm -f).
# 3. Si el volumen de datos existe:
#    a. Eliminar el volumen de Docker.
# 4. Informar al usuario que la limpieza terminó.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

if docker ps -a --format '{{.Names}}' | grep -Fxq "$CONTAINER_NAME"; then
  docker rm -f "$CONTAINER_NAME" >/dev/null
  log_info "Contenedor '$CONTAINER_NAME' eliminado."
fi

if docker volume ls --format '{{.Name}}' | grep -Fxq "$VOLUME_NAME"; then
  docker volume rm "$VOLUME_NAME" >/dev/null
  log_info "Volumen '$VOLUME_NAME' eliminado."
fi

log_success "Entorno de MySQL destruido por completo."
