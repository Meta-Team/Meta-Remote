# How to setup meta.service

1. Clone the code and name the folder "Meta-Remote/startup"
2. Go into the folder, ```sudo cp meta.service /lib/systemd/system/```
3. ```sudo systemctl daemon-reload```
4. ```systemctl enable meta.service```
5. ```chmod +x manage.sh```