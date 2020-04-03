ARG NGINX_VERSION=mainline-alpine
FROM nginx:${NGINX_VERSION}

ARG TZ=Asia/Shanghai
ARG CONTAINER_PACKAGE_URL=mirrors.aliyun.com
ARG NGINX_INSTALL_APPS=

ENV INSTALL_APPS=",${NGINX_INSTALL_APPS},"

RUN if [ "${CONTAINER_PACKAGE_URL}" != "" ]; then \
        sed -i "s/dl-cdn.alpinelinux.org/${CONTAINER_PACKAGE_URL}/g" /etc/apk/repositories; \
    fi

RUN if [ -z "${INSTALL_APPS##*,certbot,*}" ]; then \
        echo "---------- Install certbot ----------"; \
        apk add --no-cache certbot; \
    fi

WORKDIR /www
