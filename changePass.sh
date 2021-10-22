read -p "Enter username : " username
read -p "Enter password : " password
sudo echo -e "$password\n$password" | passwd $username
