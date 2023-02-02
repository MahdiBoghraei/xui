#!/bin/bash

${EMAIL:=mahdib619@gmail.com}

apt update && apt upgrade -y
apt install curl socat -y
curl https://get.acme.sh | sh
~/.acme.sh/acme.sh --set-default-ca --server letsencrypt
~/.acme.sh/acme.sh --register-account -m $(EMAIL)
~/.acme.sh/acme.sh --issue -d $(DOMAIN) --standalone
~/.acme.sh/acme.sh --installcert -d $(DOMAIN) --key-file /root/private.key --fullchain-file /root/cert.crt
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)