#!/bin/bash

basePath=$(cd "$(dirname "$0")";cd ..;pwd)

read -p "please your username: " NAME
docker run -v $basePath:/etc/openvpn --rm -it ixdotai/openvpn:0.2.3 easyrsa build-client-full $NAME nopass
docker run -v $basePath:/etc/openvpn --rm ixdotai/openvpn:0.2.3 ovpn_getclient $NAME > $basePath/conf/"$NAME".ovpn
docker restart openvpn