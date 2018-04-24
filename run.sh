#!/bin/sh
if [ -d "/run/secrets/" ]; then
  rm -rf /dev/random
  echo $(cat /run/secrets/password ) > /dev/random
  rndc-confgen -r /dev/random > /etc/rndc.conf
fi

/etc/webmin/start --nofork
/usr/sbin/named -c /etc/named.conf

