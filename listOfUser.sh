#!/bin/bash
grep '^karbaran:' /etc/group
read -p "Do You want to login with User?(y/n): " answer
if [ "$answer" == "y" ];then
	read -p "Enter username : " username
	sudo su $username
fi

