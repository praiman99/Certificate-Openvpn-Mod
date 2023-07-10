#!/bin/bash
============================
# Modified by t.me/PR_Aiman
# Copyright©Beginner
============================
# Install unzip
apt install unzip
# Openvpn Config
cd /etc/openvpn
wget https://raw.githubusercontent.com/praiman99/Certificate-Openvpn-Mod/Beginner/vpn.zip
unzip /etc/openvpn/vpn.zip
rm -f /etc/openvpn/vpn.zip 
chown -R root:root /etc/openvpn/server
# server config
cp /etc/openvpn/server/ca.crt /etc/openvpn/ca.crt
cp /etc/openvpn/server/easy-rsa/server/dh2048.pem /etc/openvpn/dh2048.pem
cp /etc/openvpn/server/server.crt /etc/openvpn/server.crt
cp /etc/openvpn/server/server.key /etc/openvpn/server.key
chmod +x /etc/openvpn/ca.crt

# Delete script
history -c
sleep 1
rm -f /root/setup.sh
