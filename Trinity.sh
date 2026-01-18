#!/bin/bash
# Trinity Desktop en Debian 13 (Trixie)
# Usando repo oficial (NO mirror)

set -e

sudo apt update
sudo apt install -y wget gnupg ca-certificates locales

KEYRING="/usr/share/keyrings/trinity.gpg"
REPO_FILE="/etc/apt/sources.list.d/trinity.list"
GPG_KEY="D6D6FAA25E93E4ECD9FB0BEC39AF1698685AD08"

sudo gpg --no-default-keyring \
 --keyring "$KEYRING" \
 --keyserver hkps://keyserver.ubuntu.com \
 --recv-keys "$GPG_KEY"

sudo chmod 644 "$KEYRING"

echo "deb [signed-by=$KEYRING] https://ppa.trinitydesktop.org/trinity/deb/trinity-r14.1.x bookworm main" \
 | sudo tee "$REPO_FILE" > /dev/null

sudo apt update
sudo apt install -y trinity tde-i18n-es tde-i18n-es-ar tde-i18n-es-es

sudo sed -i 's/^# es_AR.UTF-8 UTF-8/es_AR.UTF-8 UTF-8/' /etc/locale.gen
sudo sed -i 's/^# es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen
sudo locale-gen







