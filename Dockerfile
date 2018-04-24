FROM 	alpine

ARG	webmin_version=1.881

RUN 	apk update && \
	apk add --no-cache ca-certificates openssl perl perl-net-ssleay expect bind tzdata && \
	cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
	mkdir /opt && \
	cd /opt && \
	wget -q -O - "https://prdownloads.sourceforge.net/webadmin/webmin-$webmin_version.tar.gz" | tar xz && \
	ln -sf /opt/webmin-$webmin_version /opt/webmin	

WORKDIR	/opt/webmin

COPY	setup.exp setup.exp

RUN 	/usr/bin/expect ./setup.exp && \
	rm setup.exp && \
	apk del expect

RUN	cp /usr/sbin/named /etc/webmin && \
	sed -i 's/named_path=\/usr\/sbin\/named/named_path=\/etc\/webmin\/named/' /etc/webmin/bind8/config && \
	sed -i 's/named_conf=\/etc\/named.conf/named_conf=\/etc\/webmin\/named.conf/' /etc/webmin/bind8/config
	
VOLUME	["/etc/webmin" , "/var/webmin" ,"/etc/bind"]

COPY run.sh /opt/run.sh
RUN chmod +x /opt/run.sh
CMD ["/opt/run.sh"]
