#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

echo "================ Meta-Remote Local ================"

remote=$1
command=$2
elf=$3
if [ -z ${remote+x} ] || [ -z ${command+x} ] || [ -z ${elf+x} ];then
  echo "usage: $0 <remote host>@<remote IP> connect|flash|flash_connect <elf file>"
  exit 1
fi
if [ "$command" != "connect" ] && [ "$command" != "flash" ] && [ "$command" != "flash_connect" ];then
  echo "Invalid command ${command}. Expecting: connect, flash, or flash_connect."
  exit 1
fi
if [ ! -f "$elf" ]; then
  echo "${elf} not found."
  exit 1
fi

echo "Command: $command"
echo "ELF file: ${elf}"

# Generate MD5
md5=$(md5 -q "${elf}")
echo "MD5: ${md5}"

printf "Copying elf file to remote... "
scp "${elf}" "${remote}:/tmp/meta.elf"
printf "Done\n"

echo -e "${BLUE}Invoking remote script...${NC}"
ssh "$remote" "~/Meta-Remote/remote_openocd.sh ${command} /tmp/meta.elf ${md5}"
