#!/bin/bash

echo "--- Limpiando y configurando firmas de Trinity ---"

# 1. Eliminar configuraciones previas que puedan causar conflicto
sudo rm -f /etc/apt/sources.list.d/trinity.list
sudo rm -f /usr/local/share/keyrings/trinity-archive-keyring.gpg

# 2. Instalar dependencias base
sudo apt update
sudo apt install -y curl gnupg

# 3. Descargar y preparar la llave de forma robusta
# Usamos curl para asegurar la descarga y lo pasamos por gpg
curl -fsSL http://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-keyring.gpg | \
sudo gpg --homedir /tmp --no-default-keyring --keyring /tmp/trinity-temp.gpg --import -

# Exportar al formato binario final que Debian 13 reconoce sin errores
sudo gpg --homedir /tmp --no-default-keyring --keyring /tmp/trinity-temp.gpg --export -o /usr/local/share/keyrings/trinity-archive-keyring.gpg

# Limpiar archivos temporales de la llave
rm /tmp/trinity-temp.gpg

# 4. Asegurar permisos correctos (Lectura para todos, escritura solo root)
sudo chmod 644 /usr/local/share/keyrings/trinity-archive-keyring.gpg

# 5. Crear el repositorio con la ruta exacta de la firma
echo "deb [signed-by=/usr/local/share/keyrings/trinity-archive-keyring.gpg] http://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-sb trixie main" | sudo tee /etc/apt/sources.list.d/trinity.list
echo "deb-src [signed-by=/usr/local/share/keyrings/trinity-archive-keyring.gpg] http://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-sb trixie main" | sudo tee -a /etc/apt/sources.list.d/trinity.list

# 6. Actualizar e instalar
echo "Actualizando repositorios..."
sudo apt update

# Si el update da error aquí, es que el repo de Trinity aún no tiene rama 'trixie' estable.
# En ese caso, el script debería usar 'bookworm'.

echo "Instalando Trinity y Español..."
sudo apt install -y tde-trinity tde-i18n-es-trinity

echo "--- Proceso completado ---"
