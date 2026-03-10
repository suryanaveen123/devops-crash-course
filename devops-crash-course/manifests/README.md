# Kubernetes Manifests (Three-Tier Demo)

Apply order (DB first, then backend, then frontend):

```bash
kubectl apply -f namespace.yaml
kubectl apply -f database-secret.yaml
kubectl apply -f database-init-configmap.yaml
kubectl apply -f database-pvc.yaml
kubectl apply -f backend-configmap.yaml
kubectl apply -f backend-secret.yaml
kubectl apply -f backend-deployment.yaml
kubectl apply -f frontend-deployment.yaml
kubectl apply -f ingress.yaml
```

Build and load images (if using kind/minikube):

```bash
docker build -t frontend:latest ./app/frontend
docker build -t backend:latest ./app/backend
kind load docker-image frontend:latest backend:latest  # or minikube image load ...
```

Access: add `127.0.0.1 three-tier.local` to /etc/hosts and use an Ingress controller (e.g. ingress-nginx).
