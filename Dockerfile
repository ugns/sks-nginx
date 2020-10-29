FROM nginx:alpine
LABEL maintainer="Jeremy T. Bouse <Jeremy.Bouse@UnderGrid.net>"

COPY templates /etc/nginx/templates
COPY html /usr/share/nginx/html

ENV SKS_HKP_PORT=11371 \
    SKS_HOSTNAME=localhost \
    SERVICES_DOMAIN=local