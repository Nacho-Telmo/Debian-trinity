#!/bin/bash

echo "--- Configurando Repositorio Trinity con Firmas Correctas ---"

# 1. Asegurar que sudo esté disponible y actualizar base
sudo apt update

# 2. Instalar herramientas básicas para manejar llaves si no están
sudo apt install -y gnupg wget

# 3. Crear el directorio de llaveros si no existe
sudo mkdir -p /usr/local/share/keyrings

# 4. Descargar, desarmar (convertir a binario) y guardar la llave correctamente
# Esto soluciona el error de "Key is stored in legacy trusted.gpg keyring"
wget -qO - http://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-keyring.gpg | \
sudo gpg --dearmor --yes -o /usr/local/share/keyrings/trinity-archive-keyring.gpg

# 5. Crear el archivo de repositorio apuntando específicamente a esa firma [signed-by]
echo "deb [signed-by=/usr/local/share/keyrings/trinity-archive-keyring.gpg] http://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-sb trixie main" | sudo tee /etc/apt/sources.list.d/trinity.list
echo "deb-src [signed-by=/usr/local/share/keyrings/trinity-archive-keyring.gpg] http://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-sb trixie main" | sudo tee -a /etc/apt/sources.list.d/trinity.list

# 6. Actualizar e instalar con soporte de idioma español
sudo apt update
sudo apt install -y tde-trinity tde-i18n-es-trinity

echo "--- Instalación completada con éxito ---"
