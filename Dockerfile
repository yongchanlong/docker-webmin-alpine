FROM alpine

ARG	webmin_version=1.860

RUN 	apk update && \
	apk add --no-cache ca-certificates openssl perl perl-net-ssleay expect && \
	mkdir /opt && \
	cd /opt && \
	wget -q -O - "https://prdownloads.sourceforge.net/webadmin/webmin-$webmin_version.tar.gz" | tar xz && \
	ln -sf /opt/webmin-$webmin_version /opt/webmin	

WORKDIR	/opt/webmin

COPY	conf/setup.exp setup.exp

RUN 	/usr/bin/expect ./setup.exp && \
	rm setup.exp && \
	apk del expect

VOLUME	["/etc/webmin" , "/var/webmin"]

CMD ["/etc/webmin/start", "--nofork"]
	