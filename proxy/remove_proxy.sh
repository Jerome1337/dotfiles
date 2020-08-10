#!/bin/bash

git config --global --unset http.proxy
git config --global --unset https.proxy

if [[ -f /etc/systemd/system/docker.service.d/http-proxy.conf ]]; then
    sudo sed -i '/Environment="HTTP_PROXY=/d' /etc/systemd/system/docker.service.d/http-proxy.conf

    sudo systemctl daemon-reload
    sudo systemctl restart docker.service
fi

unset http_proxy https_proxy ftp_proxy HTTP_PROXY HTTPS_PROXY

npm config delete proxy

if [[ -f /etc/apt/apt.conf ]]; then
    sudo sed -i 's/"[^"][^"]*"/"false"/' /etc/apt/apt.conf
fi
