#!/bin/bash

echo "--- Iniciando instalación de Trinity (Método Moderno) ---"

# 1. Actualizar repositorios
sudo apt update

# 2. Instalar solo wget (necesario para bajar la llave)
sudo apt install -y wget

# 3. Descargar la llave GPG al nuevo formato de llavero (reemplaza a apt-key)
echo "Configurando llave de seguridad..."
wget -qO - http://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/trinity-keyring.gpg

# 4. Añadir el repositorio vinculándolo directamente a su llave
echo "Añadiendo repositorio de Trinity para Debian Trixie..."
echo "deb [signed-by=/usr/share/keyrings/trinity-keyring.gpg] http://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-sb trixie main" | sudo tee /etc/apt/sources.list.d/trinity.list
echo "deb-src [signed-by=/usr/share/keyrings/trinity-keyring.gpg] http://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-sb trixie main" | sudo tee -a /etc/apt/sources.list.d/trinity.list

# 5. Actualizar e instalar
sudo apt update
sudo apt install -y tde-trinity tde-i18n-es-trinity

echo "--- Instalación finalizada ---"
