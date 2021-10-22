#!/bin/bash
username=$(whoami)
##read -p "Enter username : " username
cat /home/webs/$username/alias.txt
#read -p " Enter one of the Domains in list: " domain


while [ "1" == "1" ];do
	read -p " Enter one of the Domains in list: " domain
	if grep -q $domain "/home/webs/$username/alias.txt";then
	break
	fi
done


read -p "Enter new Domain : " newDomain

bash -c "echo "127.0.0.1\	$newDomain" >> /etc/hosts"


mainDomain=$( tail -n 1 /home/webs/$username/info.txt )

sed -i "s/$domain/$newDomain/" /etc/apache2/sites-available/$mainDomain.conf

/etc/init.d/apache2 reload

