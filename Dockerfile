# nginxinc/nginx-unprivileged (not the stock nginx image) ships already
# configured to run as a non-root user: it listens on 8080 instead of 80
# (binding <1024 requires root) and its master process starts as uid 101
# (nginx) instead of root, so Kubernetes' runAsNonRoot: true works without
# extra chown/port plumbing.
FROM nginxinc/nginx-unprivileged:alpine
# ---------------------------------------------------------------------
# Stage 1: build the frontend
# ---------------------------------------------------------------------
FROM node:20-alpine AS frontend-build

WORKDIR /app

COPY sports-store-frontend/package.json sports-store-frontend/package-lock.json ./

RUN npm ci

COPY sports-store-frontend/ ./

RUN npm run build

# ---------------------------------------------------------------------
# Stage 2: serve with NGINX
# ---------------------------------------------------------------------
FROM nginx:stable-alpine
COPY sports-store-gateway/nginx.conf /etc/nginx/conf.d/default.conf
COPY sports-store-gateway/proxy_params.conf /etc/nginx/proxy_params.conf

COPY --from=frontend-build /app/dist /usr/share/nginx/html

EXPOSE 8080
