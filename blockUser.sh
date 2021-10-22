#!/bin/bash
read -p "Enter username : " username
Domain=$( tail -n 1 /home/webs/$username/info.txt )

password=$RANDOM


sudo mkdir /home/webs/blocks

sudo bash -c 'echo "<b>this is block site</b>"> /home/webs/blocks/index.html'

sudo bash -c "echo "$username" >> /home/passBlock.txt"
sudo bash -c "echo "$password" >> /home/passBlock.txt"

sudo echo -e "$password\n$password" | passwd $username

sudo bash -c "echo "$username" >> /etc/ftpusers"

sudo sed -i "s/DocumentRoot.*/DocumentRoot \/home\/webs\/blocks/" /etc/apache2/sites-available/$Domain.conf
sudo systemctl restart vsftpd
sudo systemctl reload apache2


