#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'  # No Color

echo -e "${BLUE}Change apt sources...${NC}"
sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
sudo cp sources.list /etc/apt/sources.list
echo "Done"

echo -e "${BLUE}Update apt...${NC}"
sudo apt-get update
echo "Done"

echo -e "${BLUE}Update utilities...${NC}"
sudo apt-get install -y curl telnet

echo -e "${BLUE}Install zsh and oh-my-zsh...${NC}"
sudo apt-get install -y zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "Done"

echo -e "${BLUE}Install openocd...${NC}"
sudo apt-get install -y openocd
echo "Done"