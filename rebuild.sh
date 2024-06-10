#!/bin/bash

DOMAIN="randall.hopto.org"


CERT_PATH1="/etc/letsencrypt/live/$DOMAIN/fullchain.pem"
CERT_PATH2="/etc/letsencrypt/live/$DOMAIN/privkey.pem"

OLD_CERT_PATH1="/root/SoftetherVPN-docker/cert/fullchain.pem"
OLD_CERT_PATH2="/root/SoftetherVPN-docker/cert/privkey.pem"

cd /root/SoftetherVPN-docker/

cp $CERT_PATH1 $OLD_CERT_PATH1
cp $CERT_PATH2 $OLD_CERT_PATH2

docker-compose down -v
#docker system prune -a --volumes --force
docker-compose up --build -d
docker-compose ps

docker exec -it softether-bridge vpncmd /SERVER $DOMAIN:5555 /CMD ServerPasswordSet
docker exec -it softether-bridge vpncmd /SERVER $DOMAIN:5555 /CMD SecureNatEnable
docker exec -it softether-bridge vpncmd /SERVER $DOMAIN:5555 /CMD IPsecEnable