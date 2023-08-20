#vpc
region                        = "ap-south-1"
vpc_cidr_block                = "10.0.0.0/16"
instance_tenancy              = "default"
enable_dns_support            = true
enable_dns_hostnames          = true

#elastic ip
domain                        = "vpc"

#nat-gateway
create_nat_gateway            = true

#route-table
destination_cidr_block        = "0.0.0.0/0"

#subnet
map_public_ip_on_launch       = true
public_subnet_cidr_blocks     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
app_subnet_cidr_blocks        = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
db_subnet_cidr_blocks         = ["10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24"]
management_subnet_cidr_blocks = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
availability_zones            = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]

#tags
environment                   = "dev"
application                   = "vpc"