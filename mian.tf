//----------------------------------------------------------------------------
// Sample Configuration
// https://github.com/hashicorp/learn-private-module-root/blob/master/main.tf
//----------------------------------------------------------------------------

provider "aws" {
  region = var.region
}

module "s3-webapp" {
  source  = "app.terraform.io/hashicorp-learn/s3-webapp/aws"
  name        = var.name
  region = var.region
  prefix = var.prefix
  version = "1.0.0"
}
