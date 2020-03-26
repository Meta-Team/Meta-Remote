#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'  # No Color

echo "================ Meta-Remote-Link ================"
echo

command=$1
elf=$2
md5=$3
if [[ -z $command ]]; then
    echo -e "${RED}No command is given!${NC}"
    exit 2
fi
echo "Command:      ${command}"
if [[ $command == "connect" ]]; then
    cmd="gdb_port pipe"
else
    if [[ $command == "flash" ]]; then
        cmd="program ${elf} verify reset exit"
    elif [[ $command == "flash_connect" ]]; then
        cmd="program ${elf} verify reset"
    else
        echo -e "${RED}Invalid command!${NC}"
        exit 1
    fi

    # Check inputs
    if [[ -z $elf ]]; then
        echo -e "${RED}No elf file is given!${NC}"
        exit 2
    fi
    echo "ELF file:     ${elf}"
    if [[ -z $md5 ]]; then
        echo -e "${RED}No md5 is given!${NC}"
        exit 3
    fi
    echo "Expected MD5: ${md5}"
    if [[ ! -f $elf ]]; then
        echo -e "${RED}No such file: ${elf}!${NC}"
        exit 4
    fi

    # Check MD5
    actual_md5=`md5sum ${elf} | awk '{ print $1 }'`
    echo "Actual MD5:   ${actual_md5}"
    if [[ $md5 != $actual_md5 ]]; then
        echo -e "${RED}Invalid elf file!${NC}"
        exit 5
    fi
fi
echo

echo -e "${BLUE}Starting OpenOCD...${NC}"
openocd -f ${DIR}/rm_board_stlink.cfg -c "${cmd}"