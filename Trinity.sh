#!/bin/bash
# Trinity Desktop en Debian 13 (Trixie)
# Usa repo oficial Trinity de Debian 12 (Bookworm)
# Firmas GPG válidas - método recomendado

set -e

echo "===> Instalando dependencias..."
sudo apt update
sudo apt install -y wget gnupg ca-certificates locales

KEYRING="/usr/share/keyrings/trinity.gpg"
REPO_FILE="/etc/apt/sources.list.d/trinity.list"
REPO_URL="https://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-r14.1.x"
REPO_DIST="bookworm"

echo "===> Instalando clave GPG de Trinity..."
sudo wget -qO "$KEYRING" \
  "$REPO_URL/../trinity-keyring.gpg"
sudo chmod 644 "$KEYRING"

echo "===> Agregando repositorio Trinity (bookworm)..."
echo "deb [signed-by=$KEYRING] $REPO_URL $REPO_DIST main" \
 | sudo tee "$REPO_FILE" > /dev/null

echo "===> Permitendo cambio de release para este repo..."
echo 'APT::Default-Release "trixie";' \
 | sudo tee /etc/apt/apt.conf.d/99trinity-release > /dev/null

echo "===> Actualizando índices de paquetes..."
sudo apt update

echo "===> Instalando Trinity Desktop..."
sudo apt install -y trinity

echo "===> Instalando traducciones al español..."
sudo apt install -y tde-i18n-es tde-i18n-es-ar tde-i18n-es-es

echo "===> Activando locales en español..."
sudo sed -i 's/^# es_AR.UTF-8 UTF-8/es_AR.UTF-8 UTF-8/' /etc/locale.gen
sudo sed -i 's/^# es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen
sudo locale-gen

echo "===> Instalación finalizada correctamente"
echo "Cerrá sesión y elegí Trinity en el gestor de inicio"





