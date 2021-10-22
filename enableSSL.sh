#!/bin/bash
read -p "Enter Domain : " domain
sudo certbot --apache -d $domain -d www.$domain.com
