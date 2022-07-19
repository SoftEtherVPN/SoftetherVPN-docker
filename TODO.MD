To get this publicly available there is still some work to to 


* Create a pipline for automatic building and uploading 
* define needed "flavours" / tags, (server,client,vpncmd)
* delete this file ;) 


DONE
* Get an "official" dockerhub account
* rename all references to toprock/softether


docker buildx build -t softethervpn/vpnserver:stable -f .\Dockerfile.stable --push --platform linux/amd64,linux/arm64,linux/arm/v7 .