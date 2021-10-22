#!/bin/bash
read -p "Enter username : " username
sudo adduser $username --gecos ",RoomNumber,WorkPhone,HomePhone"
read -p "Enter email : " email
sudo usermod -a -G karbaran $username
TEXTDOMAIN=virtualhost
sudo mkdir /home/webs
##enable ssh
sudo bash -c "echo "AllowUsers\ ${username}" >> /etc/ssh/sshd_config"
### Set default parameters
read -p "Enter domain : " domain
rootDir=$username
owner=$(who am i | awk '{print $1}')
apacheUser=$(ps -ef | egrep '(httpd|apache2|apache)' | grep -v root | head -n1 | awk '{print $1}')
sitesEnabled='/etc/apache2/sites-enabled/'
sitesAvailable='/etc/apache2/sites-available/'
userDir='/home/webs/'
sitesAvailabledomain=$sitesAvailable$domain.conf

### don't modify from here unless you know what you are doing ####

if [ "$(whoami)" != 'root' ]; then
	echo $"You have no permission to run $0 as non-root user. Use sudo"
		exit 1;
fi



while [ "$domain" == "" ]
do
	echo -e $"Please provide domain. e.g.dev,staging"
	read domain
done

if [ "$rootDir" == "" ]; then
	rootDir=${domain//./}
fi

### if root dir starts with '/', don't use /var/www as default starting point
if [[ "$rootDir" =~ ^/ ]]; then
	userDir=''
fi

rootDir=$userDir$rootDir

		### check if domain already exists
		if [ -e $sitesAvailabledomain ]; then
			echo -e $"This domain already exists.\nPlease Try Another one"
			exit;
		fi

		### check if directory exists or not
		if ! [ -d $rootDir ]; then
			### create the directory
			mkdir $rootDir
			### give permission to root dir
			chmod -R 755 $rootDir
			### write test file in the new domain dir
			if ! echo "<?php echo phpinfo(); ?>" > $rootDir/phpinfo.php
			then
				echo $"ERROR: Not able to write in file $rootDir/phpinfo.php. Please check permissions"
				exit;
			else
				echo $"Added content to $rootDir/phpinfo.php"
			fi
		fi
echo "$username">$rootDir/info.txt
echo "$domain" >> $rootDir/info.txt
echo "<?php echo phpinfo(); ?>" > $rootDir/phpinfo.php

		### create virtual host rules file
		if ! echo "
		<VirtualHost *:80>
			ServerAdmin $email
			ServerName $domain
			ServerAlias $domain
			DocumentRoot $rootDir
			<Directory />
				AllowOverride All
			</Directory>
			<Directory $rootDir>
				Options Indexes FollowSymLinks MultiViews
				AllowOverride all
				Require all granted
			</Directory>
			ErrorLog /var/log/apache2/$domain-error.log
			LogLevel error
			CustomLog /var/log/apache2/$domain-access.log combined
		</VirtualHost>" > $sitesAvailabledomain
		then
			echo -e $"There is an ERROR creating $domain file"
			exit;
		else
			echo -e $"\nNew Virtual Host Created\n"
		fi

		### Add domain in /etc/hosts
		if ! echo "127.0.0.1	$domain" >> /etc/hosts
		then
			echo $"ERROR: Not able to write in /etc/hosts"
			exit;
		else
			echo -e $"Host added to /etc/hosts file \n"
		fi

		chown -R $username:karbaran $rootDir
		chown -R $username:karbaran $sitesAvailabledomain
		sudo chmod 755 $sitesAvailabledomain
		### enable website
		a2ensite $domain

		### restart Apache
		/etc/init.d/apache2 reload






echo ' while [ "1" == "1" ];do
	echo "1-Change password"
	echo "2-Add Domain"
	echo "3-delete Domain"
	echo "4-change Domain"
	read -p "select Number : " number
	if [ "$number" == "1" ];then
		sudo /home/code/userChangePass.sh
	fi
	
	if [ "$number" == "2" ];then
		 /home/code/addDomain.sh
	fi

	if [ "$number" == "3" ];then
		 /home/code/deleteDomain.sh
	fi

	if [ "$number" == "4" ];then
		/home/code/changeUserDomain.sh
	fi

	
	sleep 3
	clear
	
done ' >> /home/$username/.bashrc












		### show the finished message
		echo -e $"Complete! \nYou now have a new Virtual Host \nYour new host is: http://$domain \nAnd its located at $rootDir"
		exit;
