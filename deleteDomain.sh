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
newhost=${domain//./\\.}
sed -i "/$newhost/d" /etc/hosts



mainDomain=$( tail -n 1 /home/webs/$username/info.txt )


sed -i "s/$domain/\ /" /etc/apache2/sites-available/$mainDomain.conf
/etc/init.d/apache2 reload

