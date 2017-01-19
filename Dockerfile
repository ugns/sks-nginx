FROM nginx:alpine
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY html /usr/share/nginx/html
EXPOSE 80 443 11371
CMD ["nginx", "-g", "daemon off;"]
