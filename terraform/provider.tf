terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "dcube-terraform-state"
    key    = "dev/vpc.tfstate"
    region         = "ap-south-1"
  }
}

provider "aws" {
  region = "ap-south-1"
}


###usage###

# 1. Navigate to the `environments/dev/vpc` directory: 
# 2. terraform init
# 3. terraform plan -var-file=../../../vars/dev/vpc.tfvars
# 3. terraform apply -var-file=../../../vars/dev/vpc.tfvars
# 4. terraform destroy -var-file=../../../vars/dev/vpc.tfvars