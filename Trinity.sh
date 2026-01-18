#!/bin/bash
# Instalación de Trinity Desktop Environment en Debian 13 (Trixie)
# Repositorio oficial + firmas GPG + metapaquete trinity + español
# Autor: Nacho Telmo

set -e

echo "===> Comprobando dependencias básicas..."
sudo apt update
sudo apt install -y wget gnupg ca-certificates locales

CODENAME="trixie"
KEYRING="/usr/share/keyrings/trinity.gpg"
REPO_FILE="/etc/apt/sources.list.d/trinity.list"
REPO_URL="https://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-r14.1.x"

echo "===> Instalando clave GPG de Trinity..."
sudo wget -qO "$KEYRING" \
  "$REPO_URL/../trinity-keyring.gpg"

sudo chmod 644 "$KEYRING"

echo "===> Agregando repositorio Trinity para Debian 13..."
echo "deb [signed-by=$KEYRING] $REPO_URL $CODENAME main" \
 | sudo tee "$REPO_FILE" > /dev/null

echo "===> Actualizando índices de paquetes..."
sudo apt update

echo "===> Instalando Trinity Desktop (metapaquete)..."
sudo apt install -y trinity

echo "===> Instalando soporte de idioma español..."
sudo apt install -y \
 tde-i18n-es \
 tde-i18n-es-ar \
 tde-i18n-es-es

echo "===> Habilitando locales en español..."
sudo sed -i 's/^# es_AR.UTF-8 UTF-8/es_AR.UTF-8 UTF-8/' /etc/locale.gen
sudo sed -i 's/^# es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen
sudo locale-gen

echo "===> Instalación completada correctamente"
echo "Cerrá sesión y seleccioná 'Trinity' en el gestor de inicio"




