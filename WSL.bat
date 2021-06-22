@set remote = %1%
@set command = %2%
@set elf = %3%
wsl set -i 's/\r//' ./local_openocd.sh
wsl ./local_openocd.sh %remote% %command% %elf%
