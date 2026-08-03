FROM nginx:stable-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY proxy_params.conf /etc/nginx/proxy_params.conf
COPY dist /usr/share/nginx/html

EXPOSE 80
