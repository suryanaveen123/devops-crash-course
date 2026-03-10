# DevOps Bootcamp — Teaching Schedule

A day-by-day plan to run the 15-day crash course: what to teach, when to demo, and how to keep the class clear and engaging.

---

## How to Run Each Session (1 Hour)

| Block   | Time  | Focus |
|---------|-------|--------|
| **Concepts** | 0:00–0:30 | Whiteboard / slides. One big idea, then “why it matters in production.” |
| **Demo**     | 0:30–0:50 | Live walkthrough. Use this repo’s app, manifests, Helm, or Terraform. |
| **Wrap**     | 0:50–1:00 | One small assignment + Q&A. Share repo link and next day’s topic. |

**Teaching style:** Story-first. Start with a problem (“App down at 2 AM — who gets the call? Why? How do we fix it?”), then introduce the tool or concept as the solution.

---

## Week 1 — Foundation & Why DevOps Exists

### Day 1 — DevOps Reality & Industry Overview

**Learning outcome:** They leave knowing what DevOps really is and why the role exists.

| Block    | What to do |
|----------|------------|
| **Concepts (30 min)** | Define DevOps (culture + automation). SDLC vs DevOps lifecycle. Dev pain (speed, releases) vs Ops pain (stability, security). Why companies hire and pay for this role. Toolchain in one slide: Linux → Git → Docker → CI/CD → K8s → Monitoring. **Story:** One real production incident you handled (what broke, who was called, how you fixed it). |
| **Demo (20 min)** | No code. Show this repo: README, 15-day plan, `app/` and `manifests/` from a bird’s-eye view. “By Day 15 we deploy this full stack.” |
| **Wrap (10 min)** | Assignment: Read `outline/day-02-web-server-architecture.md`. Q&A. |

**Prep:** Have one production story ready. Open repo in browser.

---

### Day 2 — Web Server Architecture + Why DevOps Exists

**Learning outcome:** They see how a request flows and where it breaks — and why DevOps is needed.

| Block    | What to do |
|----------|------------|
| **Concepts (30 min)** | Draw: Client → DNS → LB → Web Server → App Server → Database. Name each piece (Nginx, app, Postgres). Ask: “What if 10k users hit? Server dies? Wrong code? DB full? SSL expired?” Then: old world (zip file, manual deploy, downtime, blame). DevOps as the bridge. Modern flow: Code → Git → CI → Docker → K8s → Monitoring. |
| **Demo (20 min)** | Walk the three-tier app: `app/frontend`, `app/backend`, `app/database/init.sql`. Show how frontend talks to backend, backend to DB. No deploy yet — just “this is the app we’ll run everywhere.” |
| **Wrap (10 min)** | Assignment: Sketch the same flow on paper. Share `outline/day-03`. |

**Prep:** Have `app/` structure clear. Optional: run backend + Postgres locally to show one request path.

---

### Day 3 — Linux Essentials

**Learning outcome:** Comfort with files, permissions, processes, and logs.

| Block    | What to do |
|----------|------------|
| **Concepts (30 min)** | File system, `chmod`/`chown`, users/groups. Where logs live. `ps`, `top`, `systemctl`. Ports and `ss`/`netstat`. |
| **Demo (20 min)** | Terminal: create a user, set permissions, tail a log, show a process list, show what’s listening on a port. Optionally: run Nginx in a container and `curl` it. |
| **Wrap (10 min)** | Assignment: Create a user, set permission on a file, write a one-line script that lists processes. |

**Prep:** Clean terminal, one VM or container to demo on.

---

### Day 4 — Git (Condensed & Practical)

**Learning outcome:** They can use branch, merge, and PR in a normal workflow.

| Block    | What to do |
|----------|------------|
| **Concepts (30 min)** | Why version control. `clone`, `branch`, `merge`, PR flow. Resolving a merge conflict. Branching strategy: main / dev / feature. Skip internals and advanced rebase. |
| **Demo (20 min)** | Create a branch, make a change, merge (or open a PR on GitHub). Cause a conflict and resolve it. |
| **Wrap (10 min)** | Assignment: Clone this repo, create a branch, change one line in a markdown file, push, open PR (or merge locally). |

**Prep:** Repo cloned; GitHub/GitLab ready for PR demo.

---

### Day 5 — Docker

**Learning outcome:** They understand image vs container and can write a simple Dockerfile.

| Block    | What to do |
|----------|------------|
| **Concepts (30 min)** | Why containers. Image vs container. Dockerfile, layers, multi-stage (brief). Volumes and networking (basics). |
| **Demo (20 min)** | Build and run from this repo: `docker build -t frontend ./app/frontend`, `docker build -t backend ./app/backend`. Run backend with env vars pointing to a Postgres container; show `docker run`, `docker ps`, logs. |
| **Wrap (10 min)** | Assignment: Change one line in `app/frontend/index.html`, rebuild image, run and confirm. |

**Prep:** Docker installed. Postgres image or local DB for backend demo.

---

## Week 2 — Automation, IaC & Kubernetes

### Day 6 — CI/CD Concepts + Jenkins Demo

**Learning outcome:** They know what CI and CD are and see a pipeline run.

| Block    | What to do |
|----------|------------|
| **Concepts (30 min)** | CI vs CD. Build → test → deploy. Why automation. Dev → QA → Prod. |
| **Demo (20 min)** | Jenkins (or GitHub Actions): pipeline that builds the app images (or at least one), runs a simple step, and shows logs. Use `app/` as the source. |
| **Wrap (10 min)** | Assignment: Add one step to the pipeline (e.g. echo, or a simple test). |

**Prep:** Jenkins (or Actions) with access to this repo; one pipeline ready.

---

### Day 7 — Terraform Basics

**Learning outcome:** They understand IaC and the Terraform loop: init, plan, apply, destroy.

| Block    | What to do |
|----------|------------|
| **Concepts (30 min)** | What is IaC. Why clicking in the console doesn’t scale. init, plan, apply, destroy. State file (what it is, why it matters). Modules (concept only). **Story:** Real use case from your Terraform work. |
| **Demo (20 min)** | From this repo: `terraform/modules/vpc`. `terraform init`, `plan`, `apply` (or show plan only). Walk main.tf and variables. Show outputs. |
| **Wrap (10 min)** | Assignment: Change one variable (e.g. `name_prefix`), run plan, don’t apply. |

**Prep:** AWS creds; Terraform installed; maybe a separate dev AWS account.

---

### Day 8 — Terraform Advanced (Practical)

**Learning outcome:** They see remote state, modules, and dev vs prod in practice.

| Block    | What to do |
|----------|------------|
| **Concepts (30 min)** | Remote backend (S3 + DynamoDB). Variables and outputs. Workspaces or separate dirs for dev/prod. Folder structure and best practices. |
| **Demo (20 min)** | Terragrunt: `terragrunt/dev` and `terragrunt/prod`. Show different inputs (CIDR, tags). `terragrunt plan` in dev. Optionally show a backend.tf for S3. |
| **Wrap (10 min)** | Assignment: Add a tag in `terragrunt/dev/terragrunt.hcl`, run plan. |

**Prep:** Terragrunt installed; S3 backend optional.

---

### Day 9 — Kubernetes Basics

**Learning outcome:** They know Pod, Deployment, Service, Node and can read a YAML.

| Block    | What to do |
|----------|------------|
| **Concepts (30 min)** | Control plane vs workers, etcd. Pod, Deployment, Service, Node. YAML structure and key fields (name, replicas, image, port). |
| **Demo (20 min)** | Deploy Nginx from a single YAML. Then open `manifests/frontend-deployment.yaml` and `manifests/backend-deployment.yaml` — walk the fields. “Same app we saw in Docker; now as K8s resources.” |
| **Wrap (10 min)** | Assignment: Change replica count in one manifest, apply, check pods. |

**Prep:** `kubectl` and cluster (kind/minikube/EKS). Manifests from this repo.

---

### Day 10 — Kubernetes Advanced

**Learning outcome:** They’ve seen ConfigMap, Secret, Ingress, rolling updates, and HPA.

| Block    | What to do |
|----------|------------|
| **Concepts (30 min)** | ConfigMap and Secret (why, how used). Ingress and controller. Rolling update. HPA idea (scale on CPU/request). |
| **Demo (20 min)** | Apply full stack from `manifests/`: namespace, DB, backend, frontend, ingress. Show `kubectl get`, logs, and open the app in browser (or port-forward). Show one ConfigMap and one Secret. |
| **Wrap (10 min)** | Assignment: Change a value in a ConfigMap, rollout restart deployment, verify. |

**Prep:** Images built and loaded (or use a registry). Apply order from `manifests/README.md`.

---

## Week 3 — Cloud, Observability, Security & Career

### Day 11 — AWS Architecture Overview

**Learning outcome:** They can place VPC, IAM, EC2, security groups, and LB on a mental diagram.

| Block    | What to do |
|----------|------------|
| **Concepts (30 min)** | VPC, subnets, IAM, EC2, security groups, load balancer. How this connects to the Terraform VPC module they saw. |
| **Demo (20 min)** | AWS console (or Terraform state): show the VPC and subnets created by the module. Point to security group and route table. “We created this with Terraform on Day 7.” |
| **Wrap (10 min)** | Assignment: Draw a small diagram: VPC, 2 subnets, one EC2, security group, internet. |

**Prep:** One deployed VPC from Terraform/Terragrunt.

---

### Day 12 — Helm + GitOps (Short & Practical)

**Learning outcome:** They know what Helm and ArgoCD are for and see a chart deploy.

| Block    | What to do |
|----------|------------|
| **Concepts (30 min)** | Why Helm (templating, values, reuse). values.yaml. GitOps: Git as source of truth. ArgoCD in one slide. Blue–green idea. |
| **Demo (20 min)** | From this repo: `helm/three-tier-app`. Show `values.yaml` and one template. `helm install three-tier ./helm/three-tier-app -n three-tier-demo --create-namespace`. Compare with raw manifests: “same app, one command.” |
| **Wrap (10 min)** | Assignment: Change `replicaCount` in values, upgrade, list pods. |

**Prep:** Helm installed; cluster same as Day 9/10.

---

### Day 13 — Monitoring & Logging

**Learning outcome:** They understand logs vs metrics vs traces and have seen Prometheus/Grafana (and optionally ELK).

| Block    | What to do |
|----------|------------|
| **Concepts (30 min)** | Logs vs metrics vs traces. Why we need all three. Prometheus (scrape, alert). Grafana (dashboards). Centralized logging (ELK or similar) at a high level. |
| **Demo (20 min)** | Show a live Grafana dashboard (or Prometheus targets). Optionally: add a simple metric or log from the three-tier app. |
| **Wrap (10 min)** | Assignment: Find one metric or log line from the demo app and say what it means. |

**Prep:** Prometheus + Grafana (or company stack) with something to show.

---

### Day 14 — DevOps Security + Production Thinking

**Learning outcome:** They think about IAM, secrets, TLS, and incident response.

| Block    | What to do |
|----------|------------|
| **Concepts (30 min)** | IAM best practices. Secrets: never in code/repo; use secret manager or K8s Secrets. TLS basics. Vault intro if you use it. Common failures and “who gets paged, how do we debug.” |
| **Demo (20 min)** | Show how the three-tier app uses Secrets (manifests or Helm). Optionally: one IAM policy or Vault path. |
| **Wrap (10 min)** | Assignment: List three things you’d never put in Git. |

**Prep:** Examples from `manifests/*secret*` and Helm templates.

---

### Day 15 — Final Capstone + Career Masterclass

**Learning outcome:** They’ve seen one full path from infra to app to monitoring, and they have resume and interview tips.

| Block    | What to do |
|----------|------------|
| **Concepts (20 min)** | Resume: how to write a DevOps resume, what recruiters look for. Interview: scenario questions, how to answer. 3-year roadmap (e.g. 5 LPA → 20+ LPA). |
| **Demo (25 min)** | End-to-end in one flow: Terraform (VPC or cluster) → build app images → pipeline run → deploy with Helm to K8s → open app and one dashboard. Use this repo only. Narrate: “Infra as code, app in containers, pipeline, GitOps-style deploy, observability.” |
| **Wrap (15 min)** | Hand out certificate or badge if you do one. Share repo again. Open Q&A. Feedback form (optional). |

**Prep:** Full run-through once. Certificate/slide ready if offered.

---

## Quick Reference: Repo Assets by Day

| Day | Use from this repo |
|-----|---------------------|
| 1   | README, 15-day plan, high-level `app/` and `manifests/` |
| 2   | `app/frontend`, `app/backend`, `app/database/init.sql` |
| 3   | (Terminal / Nginx container) |
| 4   | Repo for clone, branch, PR |
| 5   | `app/frontend`, `app/backend` — Dockerfile and build/run |
| 6   | `app/` as pipeline source |
| 7   | `terraform/modules/vpc` — init, plan, apply |
| 8   | `terragrunt/dev`, `terragrunt/prod` |
| 9   | `manifests/frontend-deployment.yaml`, `backend-deployment.yaml` |
| 10  | Full `manifests/` apply |
| 11  | Terraform VPC in AWS (from Day 7/8) |
| 12  | `helm/three-tier-app` — values + templates, install/upgrade |
| 13  | (Existing Prometheus/Grafana; optional: app metrics/logs) |
| 14  | `manifests/*secret*`, Helm secret templates |
| 15  | Full run: Terraform → build → pipeline → Helm → dashboard |

---

## Making the Course Feel “Beautiful”

1. **Same story, same app** — From Day 2 to Day 15, keep coming back to the three-tier app. They see one system from architecture → containers → K8s → Helm → observability.
2. **One whiteboard diagram** — Draw the “full stack” once (e.g. user → LB → frontend → backend → DB + logs/metrics). Reuse and add to it each week.
3. **Real stories** — Start or end with “last month we had…” or “in production we…” so it’s not abstract.
4. **Consistent rhythm** — Same 30 / 20 / 10 every day. Same “assignment + next topic” at the end so they know what to expect.
5. **Repo as the syllabus** — Point to `outline/` and this `TEACHING-SCHEDULE.md` so they can revisit and prepare.
6. **Optional extras** — Record sessions; create a Slack channel; one short “office hour” per week; internal certificate or badge after Day 15.

Use this schedule as your teaching plan; adjust timings and depth to match your audience and environment.
