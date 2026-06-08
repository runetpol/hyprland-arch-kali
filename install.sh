#!/usr/bin/env bash

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Установка конфигов Hyprland (Kali Dark)${NC}"
echo -e "${GREEN}========================================${NC}"

# Проверка, что скрипт запускается из корня репозитория
if [ ! -d ".config" ] && [ ! -f ".zshrc" ]; then
    echo -e "${YELLOW}Внимание: не найдены .config или .zshrc. Возможно, структура не та.${NC}"
fi

# Копирование .config
if [ -d ".config" ]; then
    echo -e "${GREEN}Копирую .config в ~/.config/${NC}"
    cp -r .config/* ~/.config/
fi

# Копирование .local/bin
if [ -d ".local/bin" ]; then
    mkdir -p ~/.local/bin
    echo -e "${GREEN}Копирую .local/bin в ~/.local/bin/${NC}"
    cp -r .local/bin/* ~/.local/bin/
fi

# Копирование .zshrc
if [ -f ".zshrc" ]; then
    echo -e "${GREEN}Копирую .zshrc в ~/.zshrc${NC}"
    cp .zshrc ~/.zshrc
fi

# Установка oh-my-zsh (опционально)
read -p "Установить oh-my-zsh и плагины? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if ! command -v zsh &> /dev/null; then
        sudo pacman -S zsh --noconfirm
    fi
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
    ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" 2>/dev/null || true
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions" 2>/dev/null || true
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k" 2>/dev/null || true
    echo -e "${GREEN}oh-my-zsh и плагины установлены${NC}"
fi

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Установка завершена!                  ${NC}"
echo -e "${GREEN}  Перезагрузи Hyprland или перезайди.   ${NC}"
echo -e "${GREEN}========================================${NC}"