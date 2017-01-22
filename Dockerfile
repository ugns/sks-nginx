FROM nginx:alpine
MAINTAINER Jeremy T. Bouse <Jeremy.Bouse@UnderGrid.net>

COPY nginx /etc/nginx/
COPY html /usr/share/nginx/html

VOLUME /etc/ssl
EXPOSE 80 443 11371

CMD ["nginx", "-g", "daemon off;"]
