#!/usr/bin/env bash
# LOGICA:
# El script detiene la ejecución del contenedor de base de datos de forma suave,
# sin borrar los datos ni el contenedor, permitiendo reanudar después.
#
# PSEUDOCODIGO:
# 1. Definir el nombre del contenedor.
# 2. Verificar si el contenedor está en ejecución actualmente.
# 3. Si está corriendo:
#    a. Ejecutar 'docker stop' para detenerlo.
#    b. Informar el éxito y salir.
# 4. Si ya estaba detenido, informar que no hubo cambios.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

if docker ps --format '{{.Names}}' | grep -Fxq "$CONTAINER_NAME"; then
  docker stop "$CONTAINER_NAME" >/dev/null
  log_success "MySQL detenido."
  exit 0
fi

log_info "MySQL ya estaba detenido."
