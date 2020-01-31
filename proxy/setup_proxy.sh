#!/bin/bash

if [ -z "$1" ]; then
    echo "No proxy supplied"
    
    exit 1
fi

# Configure Git to use proxy
git config --global http.proxy "http://$1/"
git config --global https.proxy "http://$1/"

if [[ -f /etc/systemd/system/docker.service.d/http-proxy.conf ]]; then
   sudo sed -i '/Environment="HTTP_PROXY=/d' /etc/systemd/system/docker.service.d/http-proxy.conf
fi

export {http,https,ftp}_proxy="http://$1/"

# Configure APT to use proxy
echo `Acquire::http::Proxy "http://$1";` | sudo tee -a /etc/apt/apt.conf

npm config set proxy http://$1
