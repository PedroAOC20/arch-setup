#!/usr/bin/env bash
set -e

echo "Iniciando reconstrução do ambiente Arch Linux..."

if [[ $EUID -eq 0 ]]; then
  echo "Não execute este script como root."
  exit 1
fi

sudo pacman -Syu --noconfirm

echo "Instalando pacotes oficiais..."
sudo pacman -S --needed --noconfirm $(grep -v '^#' packages.txt)

if ! command -v yay &>/dev/null; then
  echo "Instalando yay (AUR helper)..."
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay
  makepkg -si --noconfirm
  cd -
fi

echo "Instalando pacotes do AUR..."
yay -S --needed --noconfirm $(grep -v '^#' aur-packages.txt)

echo "Aplicando configurações..."
mkdir -p ~/.config
rsync -av --no-perms config/ ~/.config/

echo "Processo concluído. Reinicie a sessão para aplicar tudo."
