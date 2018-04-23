#!/bin/sh
/etc/webmin/start --nofork
/usr/sbin/named -c /etc/named.conf
