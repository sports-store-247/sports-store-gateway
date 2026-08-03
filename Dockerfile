# nginxinc/nginx-unprivileged (not the stock nginx image) ships already
# configured to run as a non-root user: it listens on 8080 instead of 80
# (binding <1024 requires root) and its master process starts as uid 101
# (nginx) instead of root, so Kubernetes' runAsNonRoot: true works without
# extra chown/port plumbing.
FROM nginxinc/nginx-unprivileged:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY proxy_params.conf /etc/nginx/proxy_params.conf
COPY dist /usr/share/nginx/html

EXPOSE 8080
