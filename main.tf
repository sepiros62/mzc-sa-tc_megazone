//--------------------------------------------------------------------
// Modules
//--------------------------------------------------------------------

locals {
  # Use existing (via data source) or create new zone (will fail validation, if zone is not reachable)
  use_existing_route53_zone = true

  domain = var.domain

  # Removing trailing dot from domain - just to be sure :)
  domain_name = trimsuffix(local.domain, ".")
}

##################################################################
# Data sources to get Route53 Zone details
##################################################################
data "aws_route53_zone" "this" {
  count = local.use_existing_route53_zone ? 1 : 0

  name         = local.domain_name
  private_zone = false
}

resource "aws_route53_zone" "this" {
  count = ! local.use_existing_route53_zone ? 1 : 0
  name  = local.domain_name
}

##################################################################
# AWS Certificate Manager (ACM)
##################################################################

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> v2.0"

  domain_name = local.domain_name
  zone_id     = coalescelist(data.aws_route53_zone.this.*.zone_id, aws_route53_zone.this.*.zone_id)[0]

  subject_alternative_names = var.subject_alternative_names

  wait_for_validation = true

  tags = var.tags
}