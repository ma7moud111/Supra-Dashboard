#!/bin/sh
# Configure WiFi with static IP on wlan0

CONF="/etc/wpa_supplicant/wpa_supplicant.conf"
IP="192.168.245.250"
NETMASK="255.255.255.0"
GATEWAY="192.168.245.195"
DNS="192.168.245.195"


echo "[*] Starting wpa_supplicant"
killall wpa_supplicant 2>/dev/null
wpa_supplicant -B -i wlan0 -c $CONF

# Disable WiFi power saving (stability)
iw dev wlan0 set power_save off 2>/dev/null || true

# Assign static IP
ifconfig wlan0 $IP netmask $NETMASK up

# Set default gateway
route add default gw $GATEWAY

# Configure DNS
echo "nameserver $DNS" > /etc/resolv.conf

echo "[+] WiFi static setup complete"
