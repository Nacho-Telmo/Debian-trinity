#!/bin/bash


echo "--- Iniciando instalación de Trinity Desktop Environment (TDE) ---"

# 1. Actualizar el sistema
echo "Actualizando índices de paquetes..."
sudo apt update && apt upgrade -y

# 2. Instalar dependencias necesarias para gestionar repositorios
echo "Instalando dependencias necesarias..."
sudo apt install -y wget gnupg software-properties-common

# 3. Añadir la llave GPG del repositorio de Trinity
echo "Añadiendo llave GPG..."
wget -qO - http://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-keyring.gpg | apt-key add -

# 4. Añadir el repositorio oficial de Trinity para Debian Trixie
# Nota: Se usa 'trixie' por ser el nombre en clave de Debian 13
echo "Añadiendo repositorio de Trinity..."
echo "deb http://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-sb trixie main" > /etc/apt/sources.list.d/trinity.list
echo "deb-src http://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-sb trixie main" >> /etc/apt/sources.list.d/trinity.list

# 5. Actualizar e instalar el entorno
echo "Actualizando con el nuevo repositorio..."
sudo apt update

echo "Instalando el escritorio Trinity (mínimo)..."
# tde-trinity es el metapaquete principal
sudo rmapt install -y tde-trinity

echo "--- Instalación completada ---"
echo "Por favor, reinicia tu equipo y selecciona Trinity en la pantalla de inicio de sesión."
