#!/bin/bash
# Trinity Desktop Environment en Debian 12 (Bookworm)
# Método correcto: keyring oficial + repo firmado
# Autor: Nacho Telmo

set -e

echo "===> Instalando dependencias..."
sudo apt update
sudo apt install -y wget ca-certificates locales gnupg

KEYRING="/usr/share/keyrings/trinity.gpg"
REPO_FILE="/etc/apt/sources.list.d/trinity.list"
REPO_URL="https://ppa.trinitydesktop.org/trinity/deb/trinity-r14.1.x"

echo "===> Descargando keyring oficial de Trinity..."
sudo wget -qO "$KEYRING" \
  "$REPO_URL/../trinity-keyring.gpg"

sudo chmod 644 "$KEYRING"

echo "===> Agregando repositorio Trinity (Debian 12)..."
echo "deb [signed-by=$KEYRING] $REPO_URL bookworm main" \
 | sudo tee "$REPO_FILE" > /dev/null

echo "===> Actualizando índices de paquetes..."
sudo apt update

echo "===> Instalando Trinity Desktop..."
sudo apt install -y trinity

echo "===> Instalando idioma español..."
sudo apt install -y \
 tde-i18n-es \
 tde-i18n-es-ar \
 tde-i18n-es-es

echo "===> Configurando locales..."
sudo sed -i 's/^# es_AR.UTF-8 UTF-8/es_AR.UTF-8 UTF-8/' /etc/locale.gen
sudo sed -i 's/^# es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen
sudo locale-gen

echo "===> Instalación completada correctamente"
echo "Cerrá sesión y seleccioná Trinity en el gestor de inicio"








