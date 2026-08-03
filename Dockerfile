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

EXPOSE 80
