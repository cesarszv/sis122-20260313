#!/usr/bin/env bash

# Configuración centralizada
export CONTAINER_NAME="sis122_mysql"
export VOLUME_NAME="20260313_mysql_data"
export MYSQL_VERSION="8.4.8"
export MYSQL_PORT="3307"
export MYSQL_ROOT_PASSWORD="root_sis122_local_dev"
export MYSQL_DATABASE='sis122-20260312'
export MYSQL_USER="sis122"
export MYSQL_PASSWORD="sis122_local_dev"

# Colores para la terminal
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[1;33m'
export NC='\033[0m' # No Color

log_info()    { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error()   { echo -e "${RED}[ERROR]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }

# Verifica si Docker está corriendo
if ! docker info >/dev/null 2>&1; then
  log_error "Docker no está corriendo. Inicia Docker Desktop o el daemon de Docker."
  exit 1
fi
