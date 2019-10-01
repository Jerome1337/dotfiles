#!/bin/bash

git config --global --unset http.proxy
git config --global --unset https.proxy

if [[ -f /etc/systemd/system/docker.service.d/http-proxy.conf ]]; then
   sudo sed -i '/Environment="HTTP_PROXY=/d' /etc/systemd/system/docker.service.d/http-proxy.conf
fi

unset {http,https,ftp}_proxy

npm config delete proxy

sudo sed -i '/Acquire::http::Proxy/ s/"[^"][^"]*"/"false"/' /etc/apt/apt.conf
