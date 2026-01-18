#!/bin/bash

# Instalación de Trinity Desktop Environment en Debian 13
# Incluye repositorio, firmas GPG y soporte en español

set -e

echo "===> Actualizando sistema e instalando dependencias..."
sudo apt update
sudo apt install -y wget gnupg2 lsb-release ca-certificates apt-transport-https locales

CODENAME=$(lsb_release -cs)

echo "===> Agregando repositorio de Trinity..."
echo "deb https://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-r14.1.x ${CODENAME} main" \
 | sudo tee /etc/apt/sources.list.d/trinity.list > /dev/null

echo "===> Importando clave GPG de Trinity..."
wget -qO- https://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-keyring.gpg \
 | sudo gpg --dearmor -o /usr/share/keyrings/trinity.gpg

echo "===> Asociando firma GPG al repositorio..."
sudo sed -i \
 "s|^deb |deb [signed-by=/usr/share/keyrings/trinity.gpg] |" \
 /etc/apt/sources.list.d/trinity.list

echo "===> Actualizando índices de paquetes..."
sudo apt update

echo "===> Instalando Trinity Desktop (metapaquete)..."
sudo apt install -y trinity

echo "===> Instalando soporte de idioma español..."
sudo apt install -y \
 tde-i18n-es \
 tde-i18n-es-ar \
 tde-i18n-es-es

echo "===> Configurando locales del sistema..."
sudo sed -i 's/^# es_AR.UTF-8 UTF-8/es_AR.UTF-8 UTF-8/' /etc/locale.gen
sudo sed -i 's/^# es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen
sudo locale-gen

echo "===> Instalación completada correctamente"
echo "Cerrá sesión y seleccioná 'Trinity' en el gestor de inicio"


