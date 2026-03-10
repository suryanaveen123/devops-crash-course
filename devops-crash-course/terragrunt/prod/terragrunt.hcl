terraform {
  source = "../../terraform/modules//vpc"
}

inputs = {
  name_prefix         = "three-tier-prod"
  cidr_block          = "10.1.0.0/16"
  availability_zones   = ["us-east-1a", "us-east-1b", "us-east-1c"]
  allowed_ssh_cidrs   = ["10.0.0.0/8"]   # Restrict in prod
  allowed_http_cidrs  = ["0.0.0.0/0"]
  tags = {
    Environment = "prod"
    Project     = "three-tier-demo"
    ManagedBy   = "terragrunt"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "us-east-1"
}
EOF
}
