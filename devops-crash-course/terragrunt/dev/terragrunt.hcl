terraform {
  source = "../../terraform/modules//vpc"
}

inputs = {
  name_prefix         = "three-tier-dev"
  cidr_block          = "10.0.0.0/16"
  availability_zones   = ["us-east-1a", "us-east-1b"]
  allowed_ssh_cidrs   = ["0.0.0.0/0"]
  allowed_http_cidrs  = ["0.0.0.0/0"]
  tags = {
    Environment = "dev"
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
