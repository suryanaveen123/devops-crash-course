# AWS VPC Explained — In Plain English

A quick reference for AWS Virtual Private Cloud (VPC) and its main pieces, explained like you're not a network engineer.

---

## What is a VPC? (Virtual Private Cloud)

**Simple analogy:** A VPC is your **private section of AWS’s cloud**.  
Like a gated community: it’s inside AWS, but only your account can use it. Other customers don’t see or touch your VPC. You decide the “address plan” (IP ranges), where things live, and who can talk to whom.

---

## CIDR (Classless Inter-Domain Routing)

**What it really is:** A short way to write **“a range of IP addresses.”**

**Why it matters:** Every device needs an IP. In a VPC you don’t assign addresses one by one; you say something like: “All addresses from 10.0.0.0 to 10.0.255.255 are in this network.” CIDR is the notation for that.

**Example:**  
`10.0.0.0/16`  
- **10.0.0.0** = start of the range  
- **/16** = “how big” the range is (how many addresses you get)

**Rough size guide:**

| Notation | Meaning in plain English        | Approx. # of IPs |
|----------|---------------------------------|-------------------|
| /32     | Exactly one address             | 1                 |
| /24     | One “small” subnet              | 256               |
| /20     | A bigger block                  | 4,096             |
| /16     | A large block (common for VPC)  | 65,536            |
| /8      | Huge range                      | 16 million+       |

**Layman summary:** CIDR = “from this IP, give me this many addresses.” Smaller number after the `/` = bigger range.

---

## Subnet (Subnetwork)

**Simple analogy:** If the VPC is your **whole property**, a subnet is **one clearly defined area** in it — e.g. “front yard” vs “back yard,” each with its own address range.

**Why subnets?**

1. **Organization** — Group resources (e.g. “all web servers here,” “all databases there”).
2. **Security** — Put public-facing stuff in **public subnets**, internal-only stuff in **private subnets**.
3. **Availability** — You usually create subnets in **different Availability Zones (AZs)** so one AZ failing doesn’t take everything down.

**Rules of thumb:**

- Each subnet has **one CIDR block** (e.g. `10.0.1.0/24`).
- Subnet CIDRs must fit **inside** the VPC CIDR and **must not overlap** with each other.
- **Public subnet** = has a route to the internet (often via an Internet Gateway).  
- **Private subnet** = no direct route to the internet (or only outbound via NAT).

**Layman summary:** Subnet = one labeled “zone” inside your VPC with its own IP range and role (public vs private).

---

## Availability Zone (AZ)

**Simple analogy:** Different **physical data centers** in the same region. AWS calls them “Availability Zones” so you can spread your subnets across them.

**Why it matters:** If you put all subnets in one AZ and that AZ has a problem, everything there can be affected. So you typically create subnets in **at least 2 AZs** for resilience.

**Layman summary:** AZ = one building in the region; use more than one so a single failure doesn’t take you down.

---

## Internet Gateway (IGW)

**Simple analogy:** The **front gate** between your VPC and the public internet.

**What it does:**

- Lets traffic go **from** the internet **to** your VPC (e.g. users hitting your website).
- Lets traffic go **from** your VPC **to** the internet (e.g. your app calling an external API).

**Important:** One IGW per VPC; it’s not the thing that gives you private outbound-only access — that’s NAT.

**Layman summary:** IGW = the door to the public internet for your VPC.

---

## NAT Gateway (NAT = Network Address Translation)

**Simple analogy:** A **one-way exit only** — your private resources can go out to the internet (e.g. download updates), but the internet cannot start a connection to them.

**Why use it:**  
Resources in a **private subnet** often need to reach the internet (APIs, updates, etc.) but must not be directly reachable from the internet. NAT Gateway gives them outbound-only internet.

**Notes:**

- You put the NAT Gateway in a **public subnet** (so it can use the IGW).
- Private subnets that need outbound internet send traffic to the NAT Gateway; it forwards to the internet and sends responses back.
- NAT Gateway is a managed service; you pay for it and for data processed.

**Layman summary:** NAT Gateway = “out only” internet for private subnets — they can call out, but nobody can call in.

---

## Route Table

**Simple analogy:** A **signpost** that says: “Traffic going to X should go to Y.”

**What it does:**  
Each subnet is associated with a route table. The table has **routes** (rules) like:

- “Traffic to 0.0.0.0/0 (internet) → send to this Internet Gateway” → makes the subnet **public**.
- “Traffic to 0.0.0.0/0 → send to this NAT Gateway” → private subnet with outbound internet.
- “Traffic to 10.0.0.0/16 → stay in the VPC” → local VPC traffic.

**Layman summary:** Route table = the list of “where to send this traffic” for a subnet.

---

## Security Group

**Simple analogy:** A **firewall around a resource** (e.g. one EC2 instance or one RDS database). You define “who can send what type of traffic to this resource.”

**What you set:**

- **Inbound rules:** Who can connect in (e.g. “allow TCP 443 from 0.0.0.0/0” for a web server).
- **Outbound rules:** Where this resource can connect to (often “allow all outbound” unless you lock it down).

**Important:** Security groups are **stateful**: if you allow an inbound connection, the response is automatically allowed. Default is “deny all inbound, allow all outbound.”

**Layman summary:** Security group = “who can talk to this app/server and on which port.”

---

## Network ACL (NACL)

**Simple analogy:** A **gate at the subnet boundary** — it filters traffic entering or leaving the whole subnet, before it even reaches individual resources.

**Difference from Security Groups:**

- **Security Group** = per resource (EC2, RDS, etc.); stateful.
- **NACL** = per subnet; stateless (you may need rules for both “in” and “out” for the same flow).

**When you use it:** For an extra layer of subnet-level rules (e.g. “block this IP range from this subnet”). Many setups rely mainly on Security Groups and use default NACLs.

**Layman summary:** NACL = subnet-level firewall; Security Group = resource-level firewall.

---

## AWS Network Firewall

**Simple analogy:** A **centralized, managed firewall** that sits in your VPC and can inspect and filter traffic (by IP, port, or even by “signatures” and rules), like an enterprise firewall in a building lobby.

**What it does:**

- Filters traffic **entering or leaving** subnets you attach it to (or entire VPC with the right design).
- Can do **stateful inspection** (understands connections, not just single packets).
- Supports **allow/deny lists**, **Suricata rules**, and integration with **AWS Firewall Manager** for org-wide policy.
- You deploy it in **firewall subnets** (one per AZ you want to protect) and route traffic through it.

**When you use it:** When you need more than Security Groups and NACLs — e.g. IDS/IPS, deep packet inspection, or a single place to enforce “no outbound to bad IPs” across many VPCs.

**Layman summary:** AWS Network Firewall = a proper, managed network firewall inside your VPC that can block or allow traffic by rich rules.

---

## Transit Gateway (TGW)

**Simple analogy:** A **central hub (like an airport)** that many VPCs and on‑prem networks connect to. Instead of wiring every VPC to every other VPC, everyone connects to the hub, and the hub routes traffic between them.

**What it does:**

- You attach **VPCs**, **VPN connections**, and **Direct Connect** to one (or more) Transit Gateways.
- TGW **routes** traffic between attached networks based on route tables you configure.
- You can have **multiple route tables** (e.g. one per “segment” or account) to control who talks to whom.
- Replaces a **mesh of VPC peering** when you have many VPCs or many accounts — one hub instead of N×(N−1)/2 peering connections.

**When you use it:** Multi-VPC or multi-account networking, hybrid (AWS + on‑prem) with one central place to manage routes and (with TGW Firewall) firewall rules.

**Layman summary:** Transit Gateway = the central hub that your VPCs and on‑prem connect to so they can all talk through one place.

**TGW route tables (on the hub):**  
Like VPC route tables, but on the TGW. You decide which attachments (which VPC or VPN) can reach which CIDR ranges. “Traffic to 10.1.0.0/16 → send to attachment A (VPC A).”

**TGW attachments:**  
Each link to a VPC or VPN is an “attachment.” You associate attachments with TGW route tables so the hub knows where to send traffic.

**Layman summary:** TGW route tables = “which attachment can reach which network”; attachments = the actual links (VPC/VPN) plugged into the hub.

---

## Elastic IP (EIP)

**Simple analogy:** A **fixed public address** that you can attach to an instance (e.g. an EC2 server). Without it, the public IP can change when you stop/start the instance.

**Use case:** When you need a **stable public IP** for a server (e.g. for DNS or whitelisting). You pay for an EIP if it’s allocated but not attached to a running instance.

**Layman summary:** Elastic IP = a permanent public “phone number” for your instance.

---

## VPC Peering

**Simple analogy:** A **private connection between two VPCs** (in the same or different accounts/regions) so they can talk to each other using private IPs, without going over the public internet.

**Use case:** e.g. “VPC A has the app, VPC B has the database; let them talk privately.”

**Layman summary:** VPC Peering = a private link between two VPCs so they can communicate as if on the same network.

---

## VPC Endpoints (Gateway vs Interface)

**Simple analogy:** A **private back door** into AWS services so your VPC traffic doesn’t have to go over the public internet. Two types: **gateway** (free, only for S3/DynamoDB) and **interface** (PrivateLink, for everything else).

**Gateway endpoint:**

- Used for **S3** and **DynamoDB**.
- You add a “target” in your **route table**; no new ENI, no NAT, traffic stays on the AWS network.
- No per-hour or per-GB charge for the endpoint itself.

**Interface endpoint (PrivateLink):**

- Used for most other AWS services (e.g. ECR, CloudWatch, API Gateway, your own services).
- Creates an **ENI** in your subnet; you get a private DNS name and private IP. Traffic never hits the public internet.
- You pay per endpoint and per GB (usually small).

**Layman summary:** VPC Endpoints = private path to AWS services so traffic stays inside AWS and doesn’t go out to the internet.

---

## Virtual Private Gateway (VGW)

**Simple analogy:** The **AWS side of the door** that connects your VPC to your own network (via VPN or Direct Connect). You attach it to your VPC; the other side is your data center or office.

**What it does:**

- Attached to **one VPC**.
- Used for **Site-to-Site VPN** and **Direct Connect** (DX) — the VPN connection or DX Virtual Interface is associated with the VGW.
- You add routes in your **route table** (e.g. “traffic to 192.168.0.0/16 → send to VGW”) so your VPC knows how to reach on‑prem.

**Layman summary:** VGW = AWS’s “plug” on your VPC for VPN or Direct Connect to your own network.

---

## Customer Gateway (CGW)

**Simple analogy:** The **your side of the door** — the logical representation of *your* router or firewall that connects to AWS (for Site-to-Site VPN).

**What it does:**

- You create a CGW in AWS and give it the **public IP** of your on‑premises VPN device (and optionally BGP ASN).
- You then create a **Site-to-Site VPN connection** between the **VGW** (on the VPC) and this **CGW**.
- AWS uses this to know where to send traffic that’s destined for your on‑prem network.

**Layman summary:** CGW = “my router’s public IP” in AWS so the VPN can be set up between VGW and your side.

---

## Site-to-Site VPN (S2S VPN)

**Simple analogy:** A **secure tunnel over the internet** between your VPC (via VGW) and your data center or office (via your VPN device). Traffic is encrypted; to the VPC it looks like your office is “next door” on the network.

**What it does:**

- Encrypted connection over the public internet.
- You set up **routing** (static or BGP) so the VPC and on‑prem know how to reach each other’s CIDRs.
- Good for hybrid access without laying a physical cable; typically **two tunnels** for redundancy.

**Layman summary:** Site-to-Site VPN = encrypted tunnel over the internet connecting your VPC to your office or data center.

---

## AWS Client VPN

**Simple analogy:** **VPN for people**, not for whole networks. Like “connect to company Wi‑Fi from home” — each laptop or phone runs a VPN client and gets a private IP in your VPC so they can reach internal resources.

**What it does:**

- Users install a VPN client and connect to an **AWS Client VPN endpoint**.
- They get an IP from a pool you define and can reach resources in the VPC (and optionally on‑prem via association with a VGW).
- You control access with **security groups** and **authorization rules** (e.g. who can use which CIDR).

**Layman summary:** Client VPN = “remote access VPN” so individual users can securely reach your VPC from anywhere.

---

## Direct Connect (DX)

**Simple analogy:** A **dedicated physical cable** (or partner link) from your data center to an AWS location. No internet in the middle — private, predictable, and often higher bandwidth/lower latency than VPN over the internet.

**What it does:**

- You get a **physical connection** (or use a DX partner) into an AWS Direct Connect location.
- You create a **Virtual Interface (VIF)** — private and/or public — and associate the private VIF with a **VGW** (and thus your VPC).
- Traffic flows over that private link; you can still use **Site-to-Site VPN** as backup.

**Layman summary:** Direct Connect = a private, dedicated link from your building to AWS instead of using the public internet.

---

## Elastic Network Interface (ENI)

**Simple analogy:** A **virtual network card** for a resource in your VPC. It has a private IP (and optionally public IP), lives in a subnet, and gets its rules from Security Groups and the subnet’s NACL.

**What it does:**

- EC2 instances have at least one **primary ENI**; you can attach more for multiple IPs or to move IPs between instances.
- **VPC Interface Endpoints** and **AWS Network Firewall** also use ENIs (managed by AWS).
- ENI = “this resource’s identity on the network” (IP, MAC, SG, subnet).

**Layman summary:** ENI = the virtual network card that gives a resource its IP and ties it to a subnet and security groups.

---

## VPC Flow Logs

**Simple analogy:** A **traffic log** (who talked to whom, which port, accept or deny) for your VPC or subnet. No content of the traffic — just metadata for troubleshooting and security analysis.

**What it does:**

- You enable flow logs on a **VPC**, **subnet**, or **ENI**.
- Logs go to **CloudWatch Logs** or **S3**.
- Each record is like: “this IP:port talked to that IP:port, this protocol, accept/deny.”
- Useful for **security**, **compliance**, and **debugging** (“why can’t A reach B?”).

**Layman summary:** VPC Flow Logs = a log of network connections (metadata only) for your VPC or subnet.

---

## Egress-only Internet Gateway

**Simple analogy:** Like a **NAT Gateway but for IPv6** — allows outbound-only internet for resources that have IPv6 addresses, so they can reach the internet but the internet can’t initiate connections to them.

**What it does:**

- You attach it to the VPC and add a route in your **route table**: “::/0 → egress-only internet gateway.”
- IPv6 traffic from the subnet can go out; replies come back; inbound from the internet is blocked.

**Layman summary:** Egress-only Internet Gateway = outbound-only internet for IPv6 (like NAT for IPv4).

---

## Carrier Gateway

**Simple analogy:** A **gateway for mobile / wireless networks** (e.g. LTE, 5G). Used when your VPC is used by devices on carrier networks (e.g. IoT, vehicles) so they can reach your VPC in a controlled way.

**What it does:**

- You attach a Carrier Gateway to your VPC when you use **AWS Wavelength** or **carrier-integrated** deployments.
- It handles routing and addressing for traffic from the carrier’s network into your VPC.

**Layman summary:** Carrier Gateway = the gateway that connects your VPC to mobile/carrier networks (e.g. Wavelength).

---

## Prefix List

**Simple analogy:** A **saved list of IP ranges (or AWS service ranges)** you can reuse in security groups, NACLs, and route tables instead of typing the same CIDRs everywhere.

**What it does:**

- **Managed prefix lists**: AWS-maintained (e.g. “all S3 IPs in this region”) — you reference them in rules so you don’t have to update when S3 adds IPs.
- **Customer-managed prefix lists**: You define a set of CIDRs (e.g. “all my office IPs”) and reference that list in many SG or NACL rules.

**Layman summary:** Prefix List = a named, reusable list of CIDRs so you don’t repeat the same IP ranges in every rule.

---

## Route 53 Resolver (VPC DNS)

**Simple analogy:** **DNS inside your VPC** — how instances resolve names (e.g. `api.internal`) and how you can make your VPC use your own DNS servers or resolve names in another VPC or on‑prem.

**What it does:**

- **Inbound**: Resolver can forward queries from your VPC to your on‑prem DNS (via a Resolver Endpoint in the VPC).
- **Outbound**: Queries from on‑prem can be forwarded to a Resolver Endpoint in AWS so they can resolve names in the VPC (e.g. RDS endpoint).
- **DNS Firewall**: Optional layer to block or allow resolution of certain domains.

**Layman summary:** Route 53 Resolver = DNS resolution for your VPC and the link between VPC DNS and your own DNS (on‑prem or other VPCs).

---

## Summary Table

| Term            | One-line layman meaning                                      |
|-----------------|--------------------------------------------------------------|
| **VPC**         | Your private network space inside AWS.                      |
| **CIDR**        | A short way to write “this range of IP addresses.”           |
| **Subnet**      | A defined area inside the VPC (e.g. public vs private).      |
| **AZ**          | A separate data center in the region; use 2+ for resilience.|
| **IGW**         | The door between your VPC and the public internet.           |
| **NAT Gateway** | Outbound-only internet for private subnets (IPv4). |
| **Egress-only IGW** | Outbound-only internet for IPv6 (like NAT for IPv6). |
| **Route Table** | Tells traffic where to go (IGW, NAT, TGW, local, etc.). |
| **Security Group** | Firewall for a specific resource (who can connect, which port). |
| **NACL** | Firewall for a whole subnet (optional extra layer). |
| **AWS Network Firewall** | Managed network firewall in the VPC (IDS/IPS, deep inspection). |
| **Transit Gateway (TGW)** | Central hub connecting many VPCs and on‑prem (replace mesh peering). |
| **TGW Route Table / Attachment** | TGW routing (which attachment reaches which CIDR); attachment = link into the hub. |
| **VPC Endpoints** | Private path to AWS services (no public internet); Gateway (S3/DynamoDB) or Interface (PrivateLink). |
| **Virtual Private Gateway (VGW)** | AWS side of the door for VPN or Direct Connect into your VPC. |
| **Customer Gateway (CGW)** | Your side of the door — your VPN device's public IP in AWS. |
| **Site-to-Site VPN** | Encrypted tunnel over the internet between your VPC and your data center. |
| **Client VPN** | Remote-access VPN so individual users can reach your VPC from anywhere. |
| **Direct Connect (DX)** | Dedicated physical (or partner) link from your DC to AWS; no internet in the path. |
| **Elastic IP (EIP)** | A fixed public IP you can assign to an instance. |
| **ENI** | Virtual network card for a resource (IP, subnet, security groups). |
| **VPC Flow Logs** | Log of network traffic (metadata only) for VPC/subnet/ENI. |
| **Carrier Gateway** | Gateway for mobile/carrier networks (e.g. Wavelength). |
| **Prefix List** | Reusable list of CIDRs for use in SGs, NACLs, routes. |
| **Route 53 Resolver** | DNS in the VPC; link VPC DNS to on‑prem or other VPCs. |
| **VPC Peering** | Private link between two VPCs (no hub). |

---

*This doc is generic and not tied to any specific repo or environment.*
