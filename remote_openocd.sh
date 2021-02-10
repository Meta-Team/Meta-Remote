#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

echo "================ Meta-Remote Remote ================"

command=$1

if [ -z ${command+x} ]; then
  echo "No command is given!${NC}"
  exit 1
fi

echo "Command:      ${command}"

if [ "$command" == "connect" ]; then
  cmd="gdb_port pipe"
else
  if [ "$command" == "flash" ]; then
    cmd="program ${elf} verify reset exit"
  elif [ "$command" == "flash_connect" ]; then
    cmd="program ${elf} verify reset"
  else
    echo "Invalid command!"
    exit 1
  fi

  # Get and check inputs
  elf=$2
  md5=$3
  if [ -z ${elf+x} ]; then
    echo "No elf file is given!"
    exit 1
  fi
  if [ ! -f "$elf" ]; then
    echo "No such file: ${elf}!"
    exit 1
  fi
  if [ -z ${md5+x} ]; then
    echo "No md5 is given!"
    exit 1
  fi

  echo "ELF file:     ${elf}"
  echo "Expected MD5: ${md5}"

  # Check MD5
  actual_md5="$(md5sum "$elf" | awk '{ print $1 }')"
  echo "Actual MD5:   ${actual_md5}"
  if [ "$md5" != "$actual_md5" ]; then
    echo "Invalid elf file!"
    exit 2
  fi
fi

# Killing previous openocd (if any)
pkill -x "openocd"

openocd -f "${DIR}/rm_board_stlink.cfg" -c "${cmd}"
