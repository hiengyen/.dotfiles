#!/usr/bin/env bash

PROXY="http://192.168.141.49:10809"

mkdir -p /run/systemd/system/nix-daemon.service.d/
cat <<EOF >/run/systemd/system/nix-daemon.service.d/proxy-override.conf
[Service]
Environment="http_proxy=$PROXY"
Environment="https_proxy=$PROXY"
Environment="all_proxy=$PROXY"
EOF
systemctl daemon-reload
systemctl restart nix-daemon
