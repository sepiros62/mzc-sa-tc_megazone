//--------------------------------------------------------------------
// Modules
//--------------------------------------------------------------------

module "vpc" {
  source  = "app.terraform.io/megazonesa/vpc/aws"
  version = "2.48.0"

  name = var.name
  cidr = var.cidr

  azs = var.azs

  # subnet
  database_subnets = var.database_subnets
  private_subnets = var.private_subnets
  public_subnets = var.public_subnets

  # gateway
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway
  one_nat_gateway_per_az = var.one_nat_gateway_per_az
   
  # tag
  tags = var.tags
  database_subnet_tags = var.database_subnet_tags
  public_subnet_tags = var.public_subnet_tags
  private_subnet_tags = var.private_subnet_tags
}
