# Terragrunt

Environment-specific stacks that call the Terraform VPC module.

- **dev/** — Dev VPC (e.g. 10.0.0.0/16, 2 AZs, relaxed SSH)
- **prod/** — Prod VPC (e.g. 10.1.0.0/16, 3 AZs, restricted SSH CIDRs)

## Prerequisites

- Terraform >= 1.0
- Terragrunt
- AWS credentials configured

## Commands

```bash
# Plan/apply dev
cd dev
terragrunt init
terragrunt plan
terragrunt apply

# Plan/apply prod
cd prod
terragrunt init
terragrunt plan
terragrunt apply
```

To use remote state, configure the root `terragrunt.hcl` (S3 bucket + DynamoDB table for locking).
