//--------------------------------------------------------------------
// Modules
module "vpc" {
  source  = "app.terraform.io/megazonesa/vpc/aws"
  version = "2.48.0"

  name = "today-vpc"
  cidr = "10.50.0.0/16"

  azs = ["ap-northeast-2a", "ap-northeast-2c"]
  private_subnets = ["10.50.100.0/24", "10.50.101.0/24", "10.50.102.0/24"]

  enable_nat_gateway = "true"
  one_nat_gateway_per_az = "true"
  single_nat_gateway = "true"
}
