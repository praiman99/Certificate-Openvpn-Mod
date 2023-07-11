#!/bin/bash
#============================
# Modified by PR Aiman      #
# Copyright©Beginner2023    #
#============================
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
cp /etc/openvpn/server/dh2048.pem /etc/openvpn/dh2048.pem
cp /etc/openvpn/server/dh.pem /etc/openvpn/dh.pem
cp /etc/openvpn/server/server.crt /etc/openvpn/server.crt
cp /etc/openvpn/server/server.key /etc/openvpn/server.key
chmod +x /etc/openvpn/ca.crt

cd
mkdir -p /usr/lib/openvpn/
cp /usr/lib/x86_64-linux-gnu/openvpn/plugins/openvpn-plugin-auth-pam.so /usr/lib/openvpn/openvpn-plugin-auth-pam.so

# nano /etc/default/openvpn
sed -i 's/#AUTOSTART="all"/AUTOSTART="all"/g' /etc/default/openvpn

# Active ipv4 forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf

cd
# Restart openvpn
/etc/init.d/openvpn restart

# Enter the certificate into the TCP 1194 client .
echo '<ca>' >> /etc/openvpn/client-tcp-1194.ovpn
cat '/etc/openvpn/server/ca.crt' >> /etc/openvpn/client-tcp-1194.ovpn
echo '</ca>' >> /etc/openvpn/client-tcp-1194.ovpn

# Copy config OpenVPN client ke home directory root agar mudah didownload ( TCP 1194 )
cp /etc/openvpn/client-tcp-1194.ovpn /home/vps/public_html/client-tcp-1194.ovpn

# 2200
# Enter the certificate into the UDP 2200 client config
echo '<ca>' >> /etc/openvpn/client-udp-2200.ovpn
cat '/etc/openvpn/ca.crt' >> /etc/openvpn/client-udp-2200.ovpn
echo '</ca>' >> /etc/openvpn/client-udp-2200.ovpn

# Copy config OpenVPN client ke home directory root agar mudah didownload ( UDP 2200 )
cp /etc/openvpn/client-udp-2200.ovpn /home/vps/public_html/client-udp-2200.ovpn

# Enter the certificate into the config SSL client .
echo '<ca>' >> /etc/openvpn/client-tcp-ssl.ovpn
cat '/etc/openvpn/server/ca.crt' >> /etc/openvpn/client-tcp-ssl.ovpn
echo '</ca>' >> /etc/openvpn/client-tcp-ssl.ovpn

# restart openvpn dan cek status openvpn
systemctl enable --now openvpn-server@server-tcp-1194
systemctl enable --now openvpn-server@server-udp-2200
/etc/init.d/openvpn restart
/etc/init.d/openvpn status

# Delete script
history -c
sleep 1
rm -f /root/setup.sh

#Reboot Server
sleep 2
clear
echo ""
echo "Reboot server..."
sleep 2
reboot
