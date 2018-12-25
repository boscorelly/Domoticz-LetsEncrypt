#!/bin/bash

homedir=/home/pi/domoticz

echo "-- Stopping Domoticz --"
/etc/init.d/domoticz.sh stop

echo "-- Renewing certificate --"
certbot renew

echo "-- Deleting old certs --"
rm $homedir/server_cert.pem
rm $homedir/letsencrypt_server_cert.pem

echo "-- Merging key and chain --"
cat /etc/letsencrypt/live/domo.home.forum-pc.org/privkey.pem >> $homedir/server_cert.pem
cat /etc/letsencrypt/live/domo.home.forum-pc.org/fullchain.pem >> $homedir/server_cert.pem

echo "-- Backuping cert in case of update --"
cp $homedir/server_cert.pem $homedir/letsencrypt_server_cert.pem

echo "-- Starting Domoticz --"
/etc/init.d/domoticz.sh start
