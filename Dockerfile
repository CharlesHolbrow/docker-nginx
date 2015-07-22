FROM sameersbn/ubuntu:14.04.20150712
MAINTAINER sameer@damagehead.com

ENV RTMP_VERSION=1.1.7 \
    NPS_VERSION=1.9.32.1 \
    NGINX_VERSION=1.8.0 \
    NGINX_USER=www-data

RUN apt-get update \
 && apt-get install -y perl libssl1.0.0 libxslt1.1 libgd3 libxpm4 libgeoip1 libav-tools \
 && rm -rf /var/lib/apt/lists/*

COPY install.sh /install.sh
RUN bash /install.sh

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

COPY nginx.conf.example /etc/nginx/nginx.conf

EXPOSE 80/tcp 443/tcp 1935/tcp
VOLUME ["/etc/nginx/sites-enabled"]
CMD ["/sbin/entrypoint.sh"]
