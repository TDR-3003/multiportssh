clear
echo Installing Websocket-SSH Python
sleep 1
echo Sila Tunggu Sebentar...
sleep 0.5
cd

# // GIT USER
GitUser="YoloNet"
namafolder="websocket-python"

# // SYSTEM WEBSOCKET HTTPS 443
cat <<EOF> /etc/systemd/system/ws-https.service
[Unit]
Description=Python Proxy Mod By Manternet
Documentation=https://github.com/Manternet/
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
Restart=on-failure
ExecStart=/usr/bin/python -O /usr/local/bin/ws-https

[Install]
WantedBy=multi-user.target
EOF

# // SYSTEM WEBSOCKET HTTP 80
cat <<EOF> /etc/systemd/system/ws-http.service
[Unit]
Description=Python Proxy Mod By Manternet
Documentation=https://github.com/Manternet/
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python -O /usr/local/bin/ws-http
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF

# // SYSTEM WEBSOCKET OVPN
cat <<EOF> /etc/systemd/system/ws-ovpn.service
[Unit]
Description=Python Proxy Manternet
Documentation=https://github.com/Manternet
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python -O /usr/local/bin/ws-ovpn 2097
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# // PYTHON WEBSOCKET TLS && NONE
wget -q -O /usr/local/bin/ws-https https://raw.githubusercontent.com/YoloNet/multiportssh/main/${namafolder}/ws-https; chmod +x /usr/local/bin/ws-https

# // PYTHON WEBSOCKET DROPBEAR
wget -q -O /usr/local/bin/ws-http https://raw.githubusercontent.com/YoloNet/multiportssh/main/${namafolder}/ws-http; chmod +x /usr/local/bin/ws-http

# // PYTHON WEBSOCKET OVPN
wget -q -O /usr/local/bin/ws-ovpn https://raw.githubusercontent.com/YoloNet/multiportssh/main/${namafolder}/ws-ovpn; chmod +x /usr/local/bin/ws-ovpn

# // RESTART && ENABLE SSHVPN WEBSOCKET TLS 
systemctl daemon-reload
systemctl enable ws-https
systemctl restart ws-https
systemctl enable ws-http
systemctl restart ws-http
systemctl enable ws-ovpn
systemctl restart ws-ovpn
