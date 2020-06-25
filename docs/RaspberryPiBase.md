### Raspberry Pi Base settings

**Set DHCP server parameters**
``` 
sudo vim /etc/dhcpcd.conf
```

```
#A sample configuration for dhcpcd. <br />
hostname <br />
#Use the hardware address of the interface for the Client ID.<br />
clientid <br />
#or <br />
#Use the same DUID + IAID as set in DHCPv6 for DHCPv4 ClientID as per RFC4361. <br />
#Some non-RFC compliant DHCP servers do not reply with this set. <br />
#In this case, comment out duid and enable clientid above. <br />
duid <br />
#Persist interface configuration when dhcpcd exits. <br />
persistent <br />
#Rapid commit support. <br />
#Safe to enable by default because it requires the equivalent option set <br />
#on the server to actually work. <br />
option rapid_commit <br />
#A list of options to request from the DHCP server. <br />
option domain_name_servers, domain_name, domain_search, host_name <br />
option classless_static_routes <br />
#Respect the network MTU. This is applied to DHCP routes. <br />
option interface_mtu <br />
#Most distributions have NTP support. <br />
option ntp_servers <br />
#A ServerID is required by RFC2131. <br />
require dhcp_server_identifier <br />
#Generate SLAAC address using the Hardware Address of the interface <br />
slaac hwaddr <br />
#OR generate Stable Private IPv6 Addresses based from the DUID <br />
slaac private <br />
```


**Set network parameters**
```
sudo vim /etc/network/interfaces
```

```
# interfaces(5) file used by ifup(8) and ifdown(8) <br />
# Please note that this file is written to be used with dhcpcd <br />
# For static IP, consult /etc/dhcpcd.conf and 'man dhcpcd.conf' <br />
# Include files from /etc/network/interfaces.d: <br />
source-directory /etc/network/interfaces.d <br />
auto eth0 <br />
iface eth0 inet dhcp <br />
allow-hotplug wlan0 <br />
iface wlan0 inet static <br />
address 192.168.10.1 <br />
netmask 255.255.255.0 <br />
```
**Set WIFI router parameters**
```
sudo vim /etc/hostapd/hostapd.conf
```

```
# This is the name of the WiFi interface we configured above <br />
interface=wlan0 <br />
# Use the nl80211 driver with the brcmfmac driver <br />
driver=nl80211 <br />
# This is the name of the network <br />
ssid=igor_rtk_base <br />
# Use the 2.4GHz band <br />
hw_mode=g <br />
# Use channel 6 <br />
channel=6 <br />
# Enable 802.11n <br />
ieee80211n=1 <br />
# Enable WMM <br />
wmm_enabled=1 <br />
# Enable 40MHz channels with 20ns guard interval <br />
ht_capab=[HT40][SHORT-GI-20][DSSS_CCK-40]<br />
# Accept all MAC addresses<br />
macaddr_acl=0 <br />
# Use WPA authentication <br />
auth_algs=1 <br />
# Require clients to know the network name <br />
ignore_broadcast_ssid=0 <br />
# Use WPA2 <br />
wpa=2 <br />
# Use a pre-shared key <br />
wpa_key_mgmt=WPA-PSK <br />
# The network passphrase <br />
wpa_passphrase=raspberry <br />
# Use AES, instead of TKIP <br />
rsn_pairwise=CCMP <br />
#ignore_broadcast_ssid=1 <br />
```                                
**Configure VPN Client** 
```
wget https://git.io/vpn -O openvpn-install.sh
sudo bash openvpn-install.sh
sudo cat /etc/openvpn/update-resolv-conf
openvpn /etc/openvpn/clien/rtk1.ovpn
```
**Set up Huawei Dongle**
```
sudo route add -host 192.168.8.1 dev eth1
sudo route add -host 192.168.8.1 gw 192.168.8.0
sudo route add -host 192.168.8.1 gw 192.168.8.1
```
**Modify routing rules**

rules in the file:
```
/etc/sysconfig/iptables 
```

**Allow forwarding**
```
echo "1" >  /proc/sys/net/ipv4/ip_forward
```
