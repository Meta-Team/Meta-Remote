#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'  # No Color

echo "================ Meta-Remote-Link Local ================"

remote=$1
command=$2
elf=$3
if [[ -z $remote ]]; then
    echo -e "${RED}No remote IP is given!${NC}"
    exit 1
fi
if [[ -z $command ]]; then
    echo -e "${RED}No command is given!${NC}"
    exit 2
fi
echo "Command: ${command}"

if [[ $command != "connect" && $command != "flash" && $command != "flash_connect" ]]; then
    echo -e "${RED}Invalid command!${NC}"
    exit 1
fi

# Check inputs
if [[ -z $elf ]]; then
    echo -e "${RED}No elf file is given!${NC}"
    exit 2
fi
echo "ELF file: ${elf}"

# Generate MD5
md5=`md5 -q ${elf}`
echo "MD5: ${md5}"

echo -e "${BLUE}Copying elf file to remote...${NC}"
scp "${elf}" "${remote}:~/meta.elf"
echo -e "${GREEN}Done${NC}"

echo -e "${BLUE}Invoking remote script...${NC}"
ssh $remote "~/Meta-Remote/Remote-Link/remote.sh ${command} ~/meta.elf ${md5}"