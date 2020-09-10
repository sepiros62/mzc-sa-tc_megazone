//--------------------------------------------------------------------
// Variables
variable "vpc_database_subnet_assign_ipv6_address_on_creation" {}
variable "vpc_default_security_group_egress" {}
variable "vpc_default_security_group_ingress" {}
variable "vpc_ec2messages_endpoint_subnet_ids" {}
variable "vpc_elasticache_subnet_assign_ipv6_address_on_creation" {}
variable "vpc_enable_classiclink" {}
variable "vpc_enable_classiclink_dns_support" {}
variable "vpc_flow_log_cloudwatch_log_group_kms_key_id" {}
variable "vpc_flow_log_cloudwatch_log_group_retention_in_days" {}
variable "vpc_flow_log_log_format" {}
variable "vpc_intra_subnet_assign_ipv6_address_on_creation" {}
variable "vpc_private_subnet_assign_ipv6_address_on_creation" {}
variable "vpc_public_subnet_assign_ipv6_address_on_creation" {}
variable "vpc_redshift_subnet_assign_ipv6_address_on_creation" {}
variable "vpc_vpn_gateway_az" {}

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
