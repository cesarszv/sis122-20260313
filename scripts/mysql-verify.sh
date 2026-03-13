#!/usr/bin/env bash
# LOGICA:
# El script se asegura de que MySQL esté activo y ejecuta una serie de consultas 
# rápidas para que el usuario pueda confirmar de un vistazo el estado de la base. 
# Ahora es dinámico y muestra conteos para todas las tablas encontradas.
#
# PSEUDOCODIGO:
# 1. Asegurar que el contenedor esté arriba con 'mysql-up.sh'.
# 2. Consultar y mostrar la versión de MySQL del servidor.
# 3. Listar las tablas creadas en la base de datos de la tarea.
# 4. Generar una consulta SQL dinámica que cuente registros en todas las 
#    tablas que pertenecen a la base de datos configurada.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

# Asegurar que el contenedor está arriba
"${SCRIPT_DIR}/mysql-up.sh" >/dev/null

echo -e "\n--- RESUMEN DE ESTADO ---"

echo -e "${YELLOW}Versión:${NC}"
docker exec "$CONTAINER_NAME" mysql -N -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT VERSION();"

echo -e "\n${YELLOW}Tablas en '${MYSQL_DATABASE}':${NC}"
docker exec "$CONTAINER_NAME" mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" -e "SHOW TABLES;"

echo -e "\n${YELLOW}Conteos de registros:${NC}"
QUERY="SELECT table_name AS 'Tabla', table_rows AS 'Filas (Aprox)' FROM information_schema.tables WHERE table_schema = '${MYSQL_DATABASE}';"
# Nota: information_schema.tables puede ser inexacto para InnoDB en table_rows, 
# pero es rápido. Para ser exactos en una tarea escolar, lo ideal es COUNT(*).
# Vamos a generar una consulta de COUNT(*) para todas las tablas:

TABLES=$(docker exec "$CONTAINER_NAME" mysql -N -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" -e "SHOW TABLES;")

if [ -z "$TABLES" ]; then
  log_warn "No se encontraron tablas en la base de datos."
else
  for table in $TABLES; do
    COUNT=$(docker exec "$CONTAINER_NAME" mysql -N -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" -e "SELECT COUNT(*) FROM \`$table\`;")
    echo -e "  - ${GREEN}${table}${NC}: $COUNT registros"
  done
fi

echo -e "\n-------------------------\n"
