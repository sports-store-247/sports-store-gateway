# sports-store-gateway

Nginx reverse proxy that fronts the Sports Store backend. Serves the built frontend
static assets and proxies `/api/auth/`, `/api/catalog/`, `/api/cart/`, `/api/order/`
and `/api/payment/` to the corresponding backend service. It's the only backend-side
component meant to be reachable from outside the cluster/network.

## Stack

Nginx, Docker.

## Branching convention

- `feature/<short-description>` — new functionality
- `bugfix/<short-description>` — non-urgent fixes
- `hotfix/<short-description>` — urgent production fixes

All changes land on `main` via pull request with at least 1 approval (enforced by repository ruleset).
