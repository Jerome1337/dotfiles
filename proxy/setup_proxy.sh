#!/bin/bash

if [ -z "$1" ]; then
    echo "No proxy supplied"

    exit 1
fi

PROXY_HTTP_URL="http://$1/"
PROXY_HTTPS_URL="http://$1/"

git config --global http.proxy $PROXY_HTTP_URL
git config --global https.proxy $PROXY_HTTPS_URL

if [[ -f /etc/systemd/system/docker.service.d/http-proxy.conf ]]; then
    sudo sed -i "/Environment=HTTP_PROXY=/ s@\"\"@\"$PROXY_HTTP_URL\"@" \
        /etc/systemd/system/docker.service.d/http-proxy.conf
    sudo sed -i "/Environment=HTTPS_PROXY=/ s@\"\"@\"$PROXY_HTTPS_URL\"@" \
        /etc/systemd/system/docker.service.d/http-proxy.conf

    sudo systemctl daemon-reload
    sudo systemctl restart docker.service
fi

export http_proxy=$PROXY_HTTP_URL
export https_proxy=$PROXY_HTTPS_URL
export ftp_proxy=$PROXY_HTTP_URL
export HTTP_PROXY=$PROXY_HTTP_URL
export HTTPS_PROXY=$PROXY_HTTPS_URL

if [[ -f /etc/apt/apt.conf ]]; then
    sudo sed -i "s@false@$PROXY_HTTP_URL@" /etc/apt/apt.conf
fi

npm config set proxy $PROXY_HTTP_URL
