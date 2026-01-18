#!/bin/bash

# --- Configuración de Colores ---
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}--- Iniciando Instalación de Trinity Desktop Environment ---${NC}"

# 1. Limpieza de residuos de instalaciones fallidas
echo "Limpiando configuraciones previas..."
sudo rm -f /etc/apt/sources.list.d/trinity.list
sudo rm -f /usr/share/keyrings/trinity-archive-keyring.gpg

# 2. Instalación de requisitos previos
echo "Instalando dependencias básicas..."
sudo apt update
sudo apt install -y wget gnupg

# 3. Configuración del repositorio con bypass temporal para obtener las llaves
# Usamos [trusted=yes] solo para poder bajar el paquete oficial de firmas
echo "Configurando acceso temporal al repositorio..."
echo "deb [trusted=yes] http://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-sb trixie main" | sudo tee /etc/apt/sources.list.d/trinity.list

# 4. Instalación del paquete de llaves oficial
echo "Instalando el llavero oficial de Trinity (trinity-keyring)..."
sudo apt update
if ! sudo apt install -y --allow-unauthenticated trinity-keyring; then
    echo -e "${RED}Error: No se encontró la rama 'trixie'. Intentando con 'bookworm'...${NC}"
    echo "deb [trusted=yes] http://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-sb bookworm main" | sudo tee /etc/apt/sources.list.d/trinity.list
    sudo apt update
    sudo apt install -y --allow-unauthenticated trinity-keyring
fi

# 5. Configuración final y segura del repositorio
# Ahora quitamos el [trusted=yes] porque ya tenemos la llave instalada en el sistema
echo "Estableciendo configuración de repositorio segura..."
VERSION=$(lsb_release -c -s 2>/dev/null || echo "trixie")
# Si la instalación anterior forzó bookworm, mantenemos bookworm
if ! grep -q "trixie" /etc/apt/sources.list.d/trinity.list; then VERSION="bookworm"; fi

echo "deb http://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-sb $VERSION main" | sudo tee /etc/apt/sources.list.d/trinity.list
echo "deb-src http://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-sb $VERSION main" | sudo tee -a /etc/apt/sources.list.d/trinity.list

# 6. Actualización e Instalación Final
echo "Actualizando con firmas oficiales..."
sudo apt update

echo "Instalando Trinity Desktop y soporte para Español..."
sudo apt install -y tde-trinity tde-i18n-es-trinity

echo -e "${GREEN}--------------------------------------------------${NC}"
echo -e "${GREEN}¡Instalación completada!${NC}"
echo "Reinicia tu ordenador y selecciona TDE en la pantalla de inicio."
echo -e "${GREEN}--------------------------------------------------${NC}"
