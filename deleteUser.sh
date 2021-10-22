#!/bin/bash
read -p "Enter username : " username
Domain=$( tail -n 1 /home/webs/$username/info.txt )
newhost=${Domain//./\\.}
sed -i "/$newhost/d" /etc/hosts


### disable website
a2dissite $Domain
### restart Apache
/etc/init.d/apache2 reload
### Delete virtual host rules files
sudo rm /etc/apache2/sites-available/$Domain.conf
sudo rm -rf /home/webs/$username

sudo userdel $username

