# Three-Tier Demo Application

- **Frontend:** Nginx serving static HTML; proxies `/api/*` to backend
- **Backend:** Python Flask API (health, `/api/items` from DB)
- **Database:** PostgreSQL with `init.sql` (items table)

## Build (Docker)

```bash
docker build -t frontend ./frontend
docker build -t backend ./backend
```

Postgres uses official image; no custom build. Mount `database/init.sql` as init script in K8s/Helm.

## Run locally (optional)

```bash
# Start Postgres (create DB appdb, user appuser, password apppass)
# Then:
cd backend && pip install -r requirements.txt && DB_HOST=localhost python app.py
# Frontend: use manifests/ or Helm to run full stack, or proxy to backend manually
```
