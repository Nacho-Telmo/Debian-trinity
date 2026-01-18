#!/bin/bash
# Instalación correcta de Trinity Desktop en Debian 13
# Repositorio + firmas GPG + español
# Autor: Nacho Telmo

set -e

echo "===> Instalando dependencias necesarias..."
sudo apt update
sudo apt install -y wget gnupg ca-certificates lsb-release locales

CODENAME=$(lsb_release -cs)
KEYRING="/usr/share/keyrings/trinity.gpg"
REPO_FILE="/etc/apt/sources.list.d/trinity.list"

echo "===> Descargando e instalando clave GPG de Trinity..."
sudo wget -qO "$KEYRING" \
https://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-keyring.gpg

sudo chmod 644 "$KEYRING"

echo "===> Agregando repositorio Trinity con firma..."
echo "deb [signed-by=$KEYRING] https://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-r14.1.x $CODENAME main" \
 | sudo tee "$REPO_FILE" > /dev/null

echo "===> Actualizando listas de paquetes..."
sudo apt update

echo "===> Instalando Trinity Desktop (metapaquete)..."
sudo apt install -y trinity

echo "===> Instalando traducciones al español..."
sudo apt install -y tde-i18n-es tde-i18n-es-ar tde-i18n-es-es

echo "===> Activando locales en español..."
sudo sed -i 's/^# es_AR.UTF-8 UTF-8/es_AR.UTF-8 UTF-8/' /etc/locale.gen
sudo sed -i 's/^# es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen
sudo locale-gen

echo "===> Instalación finalizada correctamente"
echo "Cerrá sesión y elegí 'Trinity' en el gestor de inicio"




