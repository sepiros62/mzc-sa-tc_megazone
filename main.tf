//--------------------------------------------------------------------
// Modules
//--------------------------------------------------------------------

######
# VPC
######

module "vpc" {
  source  = "app.terraform.io/megazonesa/vpc/aws"
  version = "2.48.0"

  # vpc
  name                 = var.name
  cidr                 = var.cidr
  azs                  = var.azs
  enable_dns_hostnames = true
  enable_dns_support   = true

  # subnet
  private_subnets  = var.private_subnets
  public_subnets   = var.public_subnets
  database_subnets = var.database_subnets

  # gateway
  enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = var.single_nat_gateway
  one_nat_gateway_per_az = var.one_nat_gateway_per_az

  # RDS
  create_database_subnet_route_table = var.create_database_subnet_route_table
  create_database_nat_gateway_route = var.create_database_nat_gateway_route
  create_database_internet_gateway_route = var.create_database_internet_gateway_route
  create_database_subnet_group = var.create_database_subnet_group

  # tag
  tags                 = var.tags
  public_subnet_tags   = var.public_subnet_tags
  private_subnet_tags  = var.private_subnet_tags
  database_subnet_tags = var.database_subnet_tags
}
