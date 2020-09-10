//--------------------------------------------------------------------
// Modules
//--------------------------------------------------------------------

module "vpc" {
  source  = "app.terraform.io/megazonesa/vpc/aws"
  version = "2.48.0"

  name = var.name
  cidr = var.cidr

  azs = var.azs
  private_subnets = var.private_subnets
  public_subnets = var.public_subnets

  enable_nat_gateway = var.enable_nat_gateway
  one_nat_gateway_per_az = var.one_nat_gateway_per_az
  single_nat_gateway = var.single_nat_gateway

  tags = var.tags
}
