//--------------------------------------------------------------------
// Modules
//--------------------------------------------------------------------

locals {
  user_data = <<EOF
#!/bin/bash
echo "Hello Terraform!"
EOF
}

##############################################################
# Data sources to get VPC, subnets and security group details
##############################################################
data "aws_vpc" "default" {
  tags = {
    Terraform = "true"
  }
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id

  tags = {
    Tier      = "private"
    Terraform = "true"
  }
}

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
  name   = "default"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

resource "aws_iam_service_linked_role" "autoscaling" {
  aws_service_name = "autoscaling.amazonaws.com"
  description      = "A service linked role for autoscaling"
  custom_suffix    = "something"

  # Sometimes good sleep is required to have some IAM resources created before they can be used
  provisioner "local-exec" {
    command = "sleep 10"
  }
}

######
# Launch configuration and autoscaling group
######
module "asg" {
  source  = "app.terraform.io/megazonesa/autoscaling/aws"
  version = "3.7.0"

  name = var.name

  # create_lc = false # disables creation of launch configuration
  create_lc = var.create_lc

  # Launch configuration
  lc_name  = var.lc_name
  key_name = var.key_name

  image_id                     = data.aws_ami.amazon_linux.id
  instance_type                = var.instance_type
  security_groups              = [data.aws_security_group.default.id]
  associate_public_ip_address  = true
  recreate_asg_when_lc_changes = true

  user_data_base64 = base64encode(local.user_data)

  ebs_block_device = var.ebs_block_device
  root_block_device = var.root_block_device

  # Auto scaling group
  asg_name                  = var.asg_name
  vpc_zone_identifier       = data.aws_subnet_ids.all.ids
  health_check_type         = "EC2"
  desired_capacity          = var.desired_capacity
  min_size                  = var.min_size
  max_size                  = var.max_size
  wait_for_capacity_timeout = 0
  service_linked_role_arn   = aws_iam_service_linked_role.autoscaling.arn

  tags = var.tags

}