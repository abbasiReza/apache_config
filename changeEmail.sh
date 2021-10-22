#!/bin/bash
read -p "Enter username : " username
Domain=$( tail -n 1 /home/webs/$username/info.txt )
read -p "Enter new Email : " newEmail

sudo sed -i "s/ServerAdmin.*/ServerAdmin $newEmail/" /etc/apache2/sites-available/$Domain.conf
