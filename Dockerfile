FROM debian:jessie
MAINTAINER eric.fu@xealth.io

ENV RTMP_VERSION=1.1.10 \
    NPS_VERSION=1.11.33.4 \
    LIBAV_VERSION=11.8 \
    NGINX_VERSION=1.10.1 \
    NGINX_USER=www-data \
    NGINX_SITECONF_DIR=/etc/nginx/sites-enabled \
    NGINX_LOG_DIR=/var/log/nginx \
    NGINX_TEMP_DIR=/var/lib/nginx \
    NGINX_SETUP_DIR=/var/cache/nginx

ARG BUILD_LIBAV=false
ARG WITH_DEBUG=false
ARG WITH_PAGESPEED=false
ARG WITH_RTMP=false

COPY setup/ ${NGINX_SETUP_DIR}/
RUN bash ${NGINX_SETUP_DIR}/install.sh

COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 80/tcp 443/tcp

VOLUME ["${NGINX_SITECONF_DIR}"]

ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["/usr/sbin/nginx"]
