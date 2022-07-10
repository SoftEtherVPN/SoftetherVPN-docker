# SoftetherVPN-docker

This container is designed to be as small as possible and host a SoftEther VPN Server
It´s based on Alpine so resulting Image is kept as small as 15MB!

## Not working 

* bridging to a physical Ethernet adapter 

## working

* OpenVPN
* L2tp
* SSL 
* SecureNAT



## Available Tags


|Image|Description|
|---|---|
|softethervpn/vpnserver:stable|Latest stable release from https://github.com/SoftEtherVPN/SoftEtherVPN_Stable|
|softethervpn/vpnserver:v4.39-9772-beta|Tagged build|
|softethervpn/vpnserver:latest|Latest commits from https://github.com/SoftEtherVPN/SoftEtherVPN|


You should always specify your wanted version like `softethervpn/vpnserver:5.02.5180`

## Usage docker run

This will keep your config and Logfiles in the docker volume `softetherdata`

`docker run -d --rm --name softether-vpn-server -v softetherdata:/mnt -p 443:443/tcp -p 992:992/tcp -p 1194:1194/udp -p 5555:5555/tcp -p 500:500/udp -p 4500:4500/udp -p 1701:1701/udp --cap-add NET_ADMIN softethervpn/vpnserver:stable`


## Usage docker-compose

The same command can be achieved by docker-compose, the docker compose file is in the repository
```
version: '3'

services:
  softether:
    image: softethervpn/vpnserver:stable
    cap_add:
      - NET_ADMIN
    restart: always
    ports:
      - 53:53
      - 444:443
      - 992:992
      - 1194:1194/udp
      - 5555:5555
      - 500:500/udp
      - 4500:4500/udp
      - 1701:1701/udp
    volumes:
      - "/etc/localtime:/etc/localtime:ro"
      - "/etc/timezone:/etc/timezone:ro"
      - "./softether_data:/mnt"
      - "./softether_log:/root/server_log"
      - "./softether_packetlog:/root/packet_log"
      - "./softether_securitylog:/root/security_log"
```

### Use vpncmd

With newer releases vpncmd is directly in the container so you can use it to configure the vpnserver. You can can run it once the container is running :

`docker exec -it softether-vpn-server vpncmd`


## Building 

` docker build -t softethevpn:latest .`
