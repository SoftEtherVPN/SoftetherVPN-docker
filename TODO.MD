
* define needed "flavours" / tags, (server,client,vpncmd)
* delete this file ;) 


docker buildx build -t softethervpn/vpnserver:stable -f .\Dockerfile.stable --push --platform linux/amd64,linux/arm64,linux/arm/v7 .