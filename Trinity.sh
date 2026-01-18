#!/bin/bash
# Instalación de Trinity Desktop Environment en Debian 12 (Bookworm)
# Repositorio oficial + firmas GPG + metapaquete trinity + español
# Autor: Nacho Telmo

set -e

echo "===> Instalando dependencias..."
sudo apt update
sudo apt install -y wget gnupg ca-certificates locales

KEYRING="/usr/share/keyrings/trinity.gpg"
REPO_FILE="/etc/apt/sources.list.d/trinity.list"
REPO_URL="https://ppa.trinitydesktop.org/trinity/deb/trinity-r14.1.x"
GPG_KEY="D6D6FAA25E93E4ECD9FB0BEC39AF1698685AD08"

echo "===> Importando clave GPG de Trinity..."
sudo gpg --no-default-keyring \
  --keyring "$KEYRING" \
  --keyserver hkps://keyserver.ubuntu.com \
  --recv-keys "$GPG_KEY"

sudo chmod 644 "$KEYRING"

echo "===> Agregando repositorio Trinity para Debian 12..."
echo "deb [signed-by=$KEYRING] $REPO_URL bookworm main" \
 | sudo tee "$REPO_FILE" > /dev/null

echo "===> Actualizando índices..."
sudo apt update

echo "===> Instalando Trinity Desktop (metapaquete)..."
sudo apt install -y trinity

echo "===> Instalando idioma español..."
sudo apt install -y \
 tde-i18n-es \
 tde-i18n-es-ar \
 tde-i18n-es-es

echo "===> Habilitando locales..."
sudo sed -i 's/^# es_AR.UTF-8 UTF-8/es_AR.UTF-8 UTF-8/' /etc/locale.gen
sudo sed -i 's/^# es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen
sudo locale-gen

echo "===> Instalación completada correctamente"
echo "Cerrá sesión y seleccioná Trinity en el gestor de inicio"







