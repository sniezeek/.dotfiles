#!/usr/bin/env bash

set -e

REPO_URL="https://github.com//sniezeek/nvim.git"
CONFIG_DIR="$HOME/.config/nvim"

echo "=== Instalator Neovim + config ==="

# ---- Install Neovim ----
install_nvim() {
    if command -v nvim >/dev/null 2>&1; then
        echo "[OK] Neovim już zainstalowany."
    else
        echo "[INFO] Instaluję Neovim..."

        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            sudo apt update && sudo apt install -y neovim
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            brew install neovim
        else
            echo "Nieobsługiwany system: $OSTYPE"
            exit 1
        fi
    fi
}

# ---- Clone config ----
install_config() {
    echo "[INFO] Usuwam starą konfigurację..."
    rm -rf "$CONFIG_DIR"

    echo "[INFO] Klonuję repozytorium..."
    git clone "$REPO_URL" "$CONFIG_DIR"
}

# ---- Install plugin manager (lazy.nvim) ----
install_lazy() {
    echo "[INFO] Instaluję lazy.nvim..."
    git clone --filter=blob:none https://github.com/folke/lazy.nvim.git \
        ~/.local/share/nvim/lazy/lazy.nvim
}

install_nvim
install_config
install_lazy

echo "=== GOTOWE! ==="
echo "Uruchom Neovim: nvim"
