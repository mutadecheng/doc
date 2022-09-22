#!/bin/bash

basePath=$(cd "$(dirname "$0")";cd ..;pwd)

read -p "Delete username: " DNAME
docker run -v $basePath:/etc/openvpn --rm -it ixdotai/openvpn:0.2.3 easyrsa revoke $DNAME
docker run -v $basePath:/etc/openvpn --rm -it ixdotai/openvpn:0.2.3 easyrsa gen-crl
docker run -v $basePath:/etc/openvpn --rm -it ixdotai/openvpn:0.2.3 rm -f /etc/openvpn/pki/reqs/"$DNAME".req
docker run -v $basePath:/etc/openvpn --rm -it ixdotai/openvpn:0.2.3 rm -f /etc/openvpn/pki/private/"$DNAME".key
docker run -v $basePath:/etc/openvpn --rm -it ixdotai/openvpn:0.2.3 rm -f /etc/openvpn/pki/issued/"$DNAME".crt
docker restart openvpn