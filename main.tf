//--------------------------------------------------------------------
// Modules
//--------------------------------------------------------------------

##################################################################
# Data sources to get VPC and subnets
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

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
  name   = "default"
}


##################################################################
# Application Load Balancer
##################################################################

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 5.0"

  name = var.name
  
  load_balancer_type = "application"

  vpc_id             = data.aws_vpc.default.id
  subnets            = data.aws_subnet_ids.all.ids
  security_groups    = [data.aws_security_group.default.id]

  # access_logs = {
  #   bucket = "my-alb-logs"
  # }

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  target_groups = [
    {
      name_prefix          = "${var.name}-tg"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = var.health_path
        port                = "traffic-port"
        healthy_threshold   = var.healthy_threshold
        unhealthy_threshold = var.unhealthy_threshold
        timeout             = var.timeout
        protocol            = "HTTP"
        matcher             =  var.matcher
      }
    }
  ]

  tags = var.tags
  lb_tags = var.lb_tags
  target_group_tags = var.target_group_tags
