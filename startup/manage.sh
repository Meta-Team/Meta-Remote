#!/bin/sh

#echo meta | sudo -S systemctl stop nvgetty
#echo meta | sudo -S systemctl disable nvgetty
#udevadm trigger
cd /home/meta/zkr_test/
whoami > rc.log
pwd >> rc.log
echo "$PATH" >> rc.log

echo meta | sudo -S ./flush_serial /dev/ttyUSB0
echo meta | sudo -S ./flush_serial /dev/ttyTHS1
sudo python3 manager.py "socat -d /dev/ttyUSB0,b115200,raw,nonblock,ignoreeof,echo=0 TCP4-LISTEN:2021,reuseaddr" > manager.log &

exit 0
