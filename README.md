Name: Webmin
Package: webmin, bind
command :

docker run -d --name webmin -p 53:53 -p 53:53/udp -p 10000:10000 andrewai/docker-webmin-alpine

3 volumes are mounted :
/etc/webmin
/etc/bind
/var/webmin

Default admin user : admin
Default password : admin
