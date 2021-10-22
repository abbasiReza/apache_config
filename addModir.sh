#!/bin/bash
read -p "Enter username : " username
sudo adduser $username --gecos ",RoomNumber,WorkPhone,HomePhone"
sudo usermod -a -G modir $username
sudo usermod -a -G sudo $username

echo ' while [ "1" == "1" ];do
	echo "1-Create Account"
	echo "2-Create modir"
	echo "3-Visit List Of Users"
	echo "4-Delete User"
	echo "5-change Domain"
	echo "6-change Email"
	echo "7-change user password"
	echo "8-Block user"
	echo "9-enable SSL for Domain"
	read -p "select Number : " number
	if [ "$number" == "1" ];then
		sudo /home/code/createAccount.sh
	fi
	
	if [ "$number" == "2" ];then
		sudo /home/code/addModir.sh
	fi

	if [ "$number" == "3" ];then
		sudo /home/code/listOfUser.sh
	fi

	if [ "$number" == "4" ];then
		sudo /home/code/deleteUser.sh
	fi

	if [ "$number" == "5" ];then
		sudo /home/code/changeDomain.sh
	fi

	if [ "$number" == "6" ];then
		sudo /home/code/changeEmail.sh
	fi

	if [ "$number" == "7" ];then
		sudo /home/code/changePass.sh
	fi

	if [ "$number" == "8" ];then
		sudo /home/code/blockUser.sh
	fi
	
	if [ "$number" == "9" ];then
		sudo /home/code/enableSSL.sh
	fi

	sleep 3
	clear
	
done ' >> /home/$username/.bashrc
