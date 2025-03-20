#!/bin/bash
echo "Starting System Upgrade and System Update...."
sudo apt update  && sudo apt upgrade    || echo "System Update Failed...." 
sudo apt install -y nginx apache2 ufw fail2ban vim &> /dev/null || echo "Software installtion" 
echo "Software Installation and System Update Finished"
echo
echo "Starting User setup...."
sudo useradd -m johndoe
sudo passwd -d johndoe
sudo useradd -m janedoe
sudo passwd -d janedoe
echo "User setup finished..."
echo
echo
echo "Security Hardening and Logging"
echo
echo "Disabling apache2 service"
sudo systemctl disable apache2 || echo "Apache 2 disabling failed" 
echo "Successfully Disabled apache2"
echo
echo
ssh_config=/etc/ssh/sshd_config
echo "securing sshd"
echo
if grep -q "^PermitRootLogin" $ssh_config; then
	sudo sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' $ssh_config
elif grep -q "#PermitRootLogin" $ssh_config; then
	sudo sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' $ssh_config
else
	echo "PermitRootLogin no" >> $ssh_config
fi
echo
echo "Edited sshd config file"
echo
sudo systemctl restart ssh || echo "Restart ssh failed"
echo
echo
echo "server setup finished"
echo
