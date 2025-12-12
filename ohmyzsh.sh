#!/bin/bash
set -e # Stop the script immediately if any command fails

# Colors
GREEN="\033[1;32m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
NC="\033[0m"

# Check function to verify if the last command was successful
check() {
  if [ $? -eq 0 ]; then
    echo -e "${GREEN}✔ Success${NC}"
  else
    echo -e "${RED}✘ Failed${NC}"
    exit 1
  fi
}

echo -e "${YELLOW}==> Installing Oh-My-Zsh...${NC}"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  check
else
  echo -e "${GREEN}Oh-My-Zsh already installed, skipping.${NC}"
fi

# Custom path for plugins/themes
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

echo -e "${YELLOW}==> Installing plugin: zsh-autosuggestions...${NC}"
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git \
    $ZSH_CUSTOM/plugins/zsh-autosuggestions
  check
else
  echo -e "${GREEN}zsh-autosuggestions already exists, skipping.${NC}"
fi

echo -e "${YELLOW}==> Installing plugin: zsh-syntax-highlighting...${NC}"
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
  check
else
  echo -e "${GREEN}zsh-syntax-highlighting already exists, skipping.${NC}"
fi

echo -e "${YELLOW}==> Installing theme: powerlevel10k...${NC}"
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  git clone https://github.com/romkatv/powerlevel10k.git \
    $ZSH_CUSTOM/themes/powerlevel10k
  check
else
  echo -e "${GREEN}powerlevel10k already exists, skipping.${NC}"
fi

echo -e "${GREEN}==> Installation of all components completed!${NC}"
echo -e "${YELLOW}==> Add the following to your ~/.zshrc:${NC}"
echo -e "${GREEN}ZSH_THEME=\"powerlevel10k/powerlevel10k\"${NC}"
echo -e "${GREEN}plugins=(git zsh-autosuggestions zsh-syntax-highlighting)${NC}"
echo -e "${YELLOW}==> Then reload with:${NC}"
echo -e "${GREEN}source ~/.zshrc${NC}"
