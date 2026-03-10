# Virima DevOps Bootcamp – 15-Day Crash Course

Practical, production-oriented crash course for colleagues. From Linux and web architecture through CI/CD, Terraform, Kubernetes, and monitoring, with career guidance.

**Format:** 1 hour per day — 30 min concept (whiteboard), 20 min live demo, 10 min Q&A / assignment.

Slides and detailed notes are TBD; this repo holds the plan and session outlines.

**Teaching schedule:** See **[TEACHING-SCHEDULE.md](TEACHING-SCHEDULE.md)** for a day-by-day teaching plan (what to cover, demos, assignments, and which repo assets to use each day).

---

## 15-Day Plan

| Day | Topic |
|-----|--------|
| 1 | DevOps Reality & Industry Overview |
| 2 | Web Server Architecture + Why DevOps Exists |
| 3 | Linux Essentials |
| 4 | Git (Condensed & Practical) |
| 5 | Docker |
| 6 | CI/CD Concepts + Jenkins Demo |
| 7 | Terraform Basics |
| 8 | Terraform Advanced |
| 9 | Kubernetes Basics |
| 10 | Kubernetes Advanced |
| 11 | AWS Architecture Overview |
| 12 | Helm + GitOps |
| 13 | Monitoring & Logging |
| 14 | DevOps Security + Production Thinking |
| 15 | Final Capstone + Career Masterclass |

---

## Session structure (per day)

- **30 min** — Concepts (whiteboard style)
- **20 min** — Live demo
- **10 min** — Q&A / assignment

---

## Outline and session docs

- **outline/** — One markdown file per day with bullet points for that session.
- **docs/** — One session doc per day (Day 1–15) with Mermaid diagrams. Day 1 = [Web Architecture & Services](docs/day-01-web-architecture-and-services.md). Full list: [docs/README.md](docs/README.md). Expand with slides or code later as needed.

---

## Hands-on materials (capstone / demos)

| Folder | Description |
|--------|-------------|
| **app/** | Three-tier demo app: frontend (nginx), backend (Flask), database (Postgres + init.sql) |
| **manifests/** | Raw Kubernetes YAML: namespace, deployments, services, configmaps, secrets, ingress |
| **helm/three-tier-app/** | Helm chart: `Chart.yaml`, `values.yaml`, `templates/` for the same stack |
| **terraform/modules/vpc/** | Terraform module: VPC, public subnets, IGw, security group (SSH + HTTP) |
| **terragrunt/** | Terragrunt stacks: `dev/` and `prod/` calling the VPC module with env-specific inputs |

See each folder’s README for build/apply instructions.

---

## Connect this repo to GitHub

After cloning or creating this folder locally:

```bash
cd /path/to/devops-crash-course
git init
git add .
git commit -m "Initial: 15-day DevOps crash course plan"
# Create a new repository on GitHub (e.g. virima-devops-bootcamp), then:
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
git branch -M main
git push -u origin main
```

Replace `YOUR_USERNAME` and `YOUR_REPO_NAME` with your GitHub username and repository name.
