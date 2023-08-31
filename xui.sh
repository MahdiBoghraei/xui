#!/bin/bash

while getopts e:d: flag
do
    case "${flag}" in
        e) email=${OPTARG};;
        d) domain=${OPTARG};;
    esac
done

apt update && apt upgrade -y
apt install curl socat -y
apt install cron
curl https://get.acme.sh | sh
~/.acme.sh/acme.sh --set-default-ca --server letsencrypt
~/.acme.sh/acme.sh --register-account -m $email
~/.acme.sh/acme.sh --issue -d $domain --standalone
~/.acme.sh/acme.sh --installcert -d $domain --key-file /root/private.key --fullchain-file /root/cert.crt
bash <(curl -Ls https://raw.githubusercontent.com/FranzKafkaYu/x-ui/master/install_en.sh)