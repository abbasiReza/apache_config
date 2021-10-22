#!/bin/bash
username=$(whoami)
##read -p "Enter username : " username
read -p "Enter domain : " newDomain
Domain=$( tail -n 1 /home/webs/$username/info.txt )
sed -e "/ServerAlias.*/s/$/ $newDomain/" -i /etc/apache2/sites-available/$Domain.conf
bash -c "echo "127.0.0.1\	$newDomain" >> /etc/hosts"


mkdir /home/webs/$username
touch /home/webs/$username/alias.txt
chown -R $udername:karbaran /home/webs/$username/alias.txt
bash -c "echo "$newDomain" >> /home/webs/$username/alias.txt"


/etc/init.d/apache2 reload

