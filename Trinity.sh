#!/bin/bash

# Script para instalar Trinity Desktop Environment en Debian 13 (Trixie) con idioma español

echo "--- Iniciando instalación de Trinity Desktop Environment (TDE) ---"

# 1. Actualizar el sistema
echo "Actualizando índices de paquetes..."
sudo apt update && sudo apt upgrade -y

# 2. Instalar dependencias necesarias
echo "Instalando dependencias de gestión de repositorios..."
sudo apt install -y wget gnupg software-properties-common

# 3. Configurar la llave GPG del repositorio
echo "Añadiendo llave GPG de Trinity..."
# Descarga la llave y la guarda en el llavero del sistema
wget -qO - http://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-keyring.gpg | sudo apt-key add -

# 4. Añadir el repositorio oficial para Debian 13 (Trixie)
echo "Configurando repositorios para Trixie..."
sudo sh -c 'echo "deb http://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-sb trixie main" > /etc/apt/sources.list.d/trinity.list'
sudo sh -c 'echo "deb-src http://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-sb trixie main" >> /etc/apt/sources.list.d/trinity.list'

# 5. Actualizar con el nuevo repositorio
echo "Sincronizando con el repositorio de Trinity..."
sudo apt update

# 6. Instalación del escritorio y soporte de idioma español
echo "Instalando escritorio Trinity y paquetes de idioma español..."
# tde-trinity: Base del escritorio
# tde-i18n-es-trinity: Traducciones al español
# tde-i18n-es-ar-trinity: (Opcional) Si prefieres español de Argentina
sudo apt install -y tde-trinity tde-i18n-es-trinity

echo "--- Proceso finalizado ---"
echo "Recomendación: Reinicia el sistema para aplicar los cambios."
echo "En la pantalla de login, selecciona 'TDE' o 'Trinity' como entorno."
