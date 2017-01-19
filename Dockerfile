FROM nginx:alpine
MAINTAINER Jeremy T. Bouse <Jeremy.Bouse@UnderGrid.net>
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY html /usr/share/nginx/html
VOLUME /etc/ssl
EXPOSE 80 443 11371
CMD ["nginx", "-g", "daemon off;"]
