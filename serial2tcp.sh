#!/bin/bash

echo "[`date +%Y-%m-%d %H:%M:%S`]"
sudo socat TCP-LISTEN:2560,fork,reuseaddr FILE:/dev/ttyUSB0,rawer,b115200,nonblock