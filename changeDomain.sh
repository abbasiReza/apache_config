#!/bin/bash
read -p "Enter username : " username
oldDomain=$( tail -n 1 /home/webs/$username/info.txt )
read -p "Enter new Domain : " newDomain

echo $username
echo $oldDomain
echo $newDomain



sudo sed -i "s/$oldDomain$/$newDomain/" /etc/hosts

sudo sed -i "s/$oldDomain/$newDomain/" /etc/apache2/sites-available/$oldDomain.conf

sudo mv /etc/apache2/sites-available/$oldDomain.conf /etc/apache2/sites-available/$newDomain.conf

sudo bash -c "echo $newDomain >> /home/webs/$username/info.txt"

sudo a2dissite $oldDomain

sudo a2ensite $newDomain

/etc/init.d/apache2 reload
