#!/bin/bash
# Trinity Desktop en Debian 13 (Trixie)
# Solución definitiva a errores de firma GPG

set -e

echo "===> Instalando dependencias..."
sudo apt update
sudo apt install -y wget gnupg ca-certificates locales

KEYRING="/usr/share/keyrings/trinity.gpg"
REPO_FILE="/etc/apt/sources.list.d/trinity.list"
REPO_URL="https://ppa.trinitydesktop.org/trinity/deb/trinity-r14.1.x"
REPO_DIST="bookworm"
GPG_KEY="D6D6FAA25E93E4ECD9FB0BEC39AF1698685AD08"

echo "===> Importando clave GPG correcta de Trinity..."
sudo gpg --no-default-keyring \
 --keyring "$KEYRING" \
 --keyserver hkps://keyserver.ubuntu.com \
 --recv-keys "$GPG_KEY"

sudo chmod 644 "$KEYRING"

echo "===> Agregando repositorio Trinity (bookworm firmado)..."
echo "deb [signed-by=$KEYRING] $REPO_URL $REPO_DIST main" \
 | sudo tee "$REPO_FILE" > /dev/null

echo "===> Actualizando índices..."
sudo apt update

echo "===> Instalando Trinity Desktop..."
sudo apt install -y trinity

echo "===> Instalando idioma español..."
sudo apt install -y tde-i18n-es tde-i18n-es-ar tde-i18n-es-es

echo "===> Activando locales..."
sudo sed -i 's/^# es_AR.UTF-8 UTF-8/es_AR.UTF-8 UTF-8/' /etc/locale.gen
sudo sed -i 's/^# es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen
sudo locale-gen

echo "===> Instalación completada correctamente"
echo "Cerrá sesión y seleccioná Trinity"






