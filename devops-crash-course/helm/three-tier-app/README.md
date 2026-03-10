# three-tier-app Helm Chart

Deploy the three-tier demo (frontend, backend, Postgres) via Helm.

## Install

```bash
# From repo root
helm install three-tier ./helm/three-tier-app -n three-tier-demo --create-namespace
```

## Upgrade

```bash
helm upgrade three-tier ./helm/three-tier-app -n three-tier-demo
```

## Customize

Edit `values.yaml` (replicas, image tags, DB auth, ingress host, persistence size).

## Uninstall

```bash
helm uninstall three-tier -n three-tier-demo
```
