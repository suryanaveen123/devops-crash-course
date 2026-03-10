# Day 2 – Web Server Architecture + Why DevOps Exists

- Basic web flow: Client → DNS → Load Balancer → Web Server → App Server → Database
- Break down: DNS, LB, Nginx reverse proxy, backend app, database
- Failure scenarios: 10k users at once, server crash, wrong code push, DB full, SSL expiry, CPU 100%
- Old flow: Dev → zip → admin → manual deploy → restart → downtime
- Problems: no version control, no rollback, no automation, no scaling, no monitoring, blame game
- DevOps as the bridge: Dev wants speed/automation, Ops wants stability/security
- Modern flow: Code → Git → CI → Docker → Registry → Kubernetes → Monitoring → Logs → Alerts
