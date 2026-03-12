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

## Summary Table

| Term            | One-line layman meaning                                      |
|-----------------|--------------------------------------------------------------|
| **VPC**         | Your private network space inside AWS.                      |
| **CIDR**        | A short way to write “this range of IP addresses.”           |
| **Subnet**      | A defined area inside the VPC (e.g. public vs private).      |
| **AZ**          | A separate data center in the region; use 2+ for resilience.|
| **IGW**         | The door between your VPC and the public internet.           |
| **NAT Gateway** | Outbound-only internet for private subnets.                  |
| **Route Table** | Tells traffic where to go (IGW, NAT, local, etc.).          |
| **Security Group** | Firewall for a specific resource (who can connect, which port). |
| **NACL**        | Firewall for a whole subnet (optional extra layer).         |
| **Elastic IP**  | A fixed public IP you can assign to an instance.            |
| **VPC Peering** | Private link between two VPCs.                               |

---

*This doc is generic and not tied to any specific repo or environment.*
