# Terraform Module (VPC)

Module: `modules/vpc` — creates VPC, public subnets, internet gateway, route table, and a security group (SSH + HTTP).

## Usage (direct Terraform)

```bash
cd terraform/modules/vpc
terraform init
terraform plan -var="name_prefix=my-demo" -var='availability_zones=["us-east-1a","us-east-1b"]'
terraform apply ...
```

## Usage (Terragrunt)

From repo root:

```bash
# Dev
cd terragrunt/dev && terragrunt init && terragrunt plan && terragrunt apply

# Prod
cd terragrunt/prod && terragrunt init && terragrunt plan && terragrunt apply
```

Terragrunt uses the same module with different inputs (dev vs prod). Add a root `terragrunt.hcl` and remote_state block for shared S3 backend when ready.
