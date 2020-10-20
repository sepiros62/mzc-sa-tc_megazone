//--------------------------------------------------------------------
// Modules
//--------------------------------------------------------------------

locals {
  user_data = <<EOF
#!/bin/bash
echo "Hello Terraform!"
EOF
}


##################################################################
# Data sources to get VPC, subnet, security group and AMI details
##################################################################
data "aws_vpc" "default" {
  tags = {
    Terraform = "true"
  }
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id

  tags = {
    Tier      = "public"
    Terraform = "true"
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

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


##################################################################
# Bastion Host Instance (EC2)
##################################################################

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name        = "${var.name}-sg"
  description = "Security group for example usage with EC2 instance"
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks = var.ingress_cidr_blocks
  ingress_rules       = ["ssh-tcp"]
  egress_rules        = ["all-all"]
}

resource "aws_eip" "this" {
  vpc      = true
  instance = module.ec2_cluster.id[0]
  tags = {
    Name = "${var.name}-eip"
  }
}

module "ec2_cluster" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  instance_count = 1

  name                        = var.name
  key_name                    = var.key_name
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = tolist(data.aws_subnet_ids.all.ids)[0]
  vpc_security_group_ids      = [module.security_group.this_security_group_id]
  associate_public_ip_address = true

  user_data_base64 = base64encode(local.user_data)

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 10
    },
  ]

  tags        = var.tags
  volume_tags = var.volume_tags
}
