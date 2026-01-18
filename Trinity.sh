#!/bin/bash
set -e

echo "===> Instalador automático Trinity Desktop - Debian 12"

### VARIABLES
DIST="bookworm"
REPO_URL="https://mirror.trinitydesktop.org/trinity/deb/trinity-r14"
KEYRING="/usr/share/keyrings/trinity.gpg"
LIST_FILE="/etc/apt/sources.list.d/trinity.list"

### 1. Comprobar sudo
if ! sudo -n true 2>/dev/null; then
  echo "ERROR: El usuario debe tener permisos sudo"
  exit 1
fi

### 2. Dependencias necesarias
echo "===> Instalando dependencias..."
sudo apt update -qq
sudo apt install -y wget ca-certificates gnupg locales

### 3. Descargar keyring oficial (método moderno)
echo "===> Descargando keyring oficial de Trinity..."
sudo wget -qO "$KEYRING" \
https://mirror.trinitydesktop.org/trinity/deb/trinity-keyring.gpg

sudo chmod 644 "$KEYRING"

### 4. Agregar repositorio Trinity
echo "===> Agregando repositorio Trinity..."
echo "deb [signed-by=$KEYRING] $REPO_URL $DIST main" | sudo tee "$LIST_FILE" > /dev/null

### 5. Actualizar índices
echo "===> Actualizando repositorios..."
sudo apt update -qq

### 6. Instalar Trinity Desktop completo
echo "===> Instalando Trinity Desktop..."
sudo DEBIAN_FRONTEND=noninteractive apt install -y trinity

### 7. Configurar idioma español
echo "===> Configurando idioma español..."
sudo sed -i 's/^# *es_AR.UTF-8 UTF-8/es_AR.UTF-8 UTF-8/' /etc/locale.gen
sudo sed -i 's/^# *es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen
sudo locale-gen
sudo update-locale LANG=es_AR.UTF-8

### 8. Final
echo "========================================"
echo "Trinity Desktop instalado correctamente"
echo "Idioma: Español"
echo "Reiniciá el sistema y elegí Trinity en el login"
echo "========================================"










