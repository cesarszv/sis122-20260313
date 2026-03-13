#!/usr/bin/env bash
# LOGICA:
# El script se asegura de que MySQL esté activo, borra la base de datos actual 
# para limpiarla por completo, la recrea y finalmente carga los archivos SQL 
# en el orden correcto (primero tablas, luego datos adicionales).
#
# PSEUDOCODIGO:
# 1. Definir rutas del proyecto y credenciales.
# 2. Asegurarse de que el contenedor esté arriba llamando a 'mysql-up.sh'.
# 3. Mandar una instrucción SQL al contenedor para que:
#    a. Borre la base si existe.
#    b. Cree la base desde cero con el charset utf8mb4.
# 4. Cargar 'defineTables.sql' primero.
# 5. Cargar todos los archivos 'from*.sql' en orden alfabético.
# 6. Confirmar que los datos fueron recargados.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"
ASSIGNMENT_DIR="$(cd "${SCRIPT_DIR}/../assignment" && pwd)"

# Asegurar que el contenedor está arriba
"${SCRIPT_DIR}/mysql-up.sh"

log_info "Limpiando y recreando base de datos: ${MYSQL_DATABASE}..."
docker exec "$CONTAINER_NAME" mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "DROP DATABASE IF EXISTS \`${MYSQL_DATABASE}\`; CREATE DATABASE \`${MYSQL_DATABASE}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;"

# Cargar esquema principal
if [ -f "${ASSIGNMENT_DIR}/defineTables.sql" ]; then
  log_info "Cargando esquema: defineTables.sql"
  docker exec -i "$CONTAINER_NAME" mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" < "${ASSIGNMENT_DIR}/defineTables.sql"
else
  log_error "No se encontró defineTables.sql en ${ASSIGNMENT_DIR}"
  exit 1
fi

# Cargar archivos de datos de forma dinámica
log_info "Cargando datos adicionales..."
# Usamos sort para asegurar el orden 1-5, 6-10, 11-14
for sql_file in $(ls "${ASSIGNMENT_DIR}"/from*.sql | sort -V); do
  log_info "Cargando: $(basename "$sql_file")"
  docker exec -i "$CONTAINER_NAME" mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" < "$sql_file"
done

log_success "Base de datos '${MYSQL_DATABASE}' recreada y cargada con éxito."
