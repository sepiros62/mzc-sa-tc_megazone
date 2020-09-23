//--------------------------------------------------------------------
// Modules
//--------------------------------------------------------------------

###############
# Data sources 
###############
data "aws_vpc" "default" {
  tags = {
    Terraform = "true"
  }
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id

  tags = {
    RDS       = "true"
    Terraform = "true"
  }
}

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
  name   = "default"
}


#############
# RDS Aurora
#############
module "aurora" {
  source  = "app.terraform.io/megazonesa/rds-aurora/aws"
  version = "~> 2.0"

  # Aurora Engine Option
  engine         = var.engine
  engine_mode    = "provisioned"
  engine_version = var.engine_version

  # Aurora Settings
  name     = var.name
  username = var.username
  password = var.password

  # Aurora DB Instance size
  instance_type = var.instance_type

  # Aurora Availability & durability
  replica_count = var.replica_count

  # Aurora Connectivity
  vpc_id                 = data.aws_vpc.default.id
  subnets                = data.aws_subnet_ids.all.ids
  vpc_security_group_ids = [data.aws_security_group.default.id]

  # Aurora DB authentication
  iam_database_authentication_enabled = false

  # Aurora Additional configuration
  database_name                = var.database_name
  backup_retention_period      = "7"
  backup_window                = "03:00-06:00"
  final_snapshot_identifier    = var.final_snapshot_identifier
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  storage_encrypted            = false
  performance_insights_enabled = false

  db_parameter_group_name         = aws_db_parameter_group.aurora_db_parameter_group.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_cluster_parameter_group.id

  # Aurora Tags
  tags = var.tags
}

#############################
# Aurora Parameter Group
#############################
resource "aws_db_parameter_group" "aurora_db_parameter_group" {
  name        = var.pg_name
  family      = var.pg_family
  description = "test-aurora-db-57-parameter-group"
}

resource "aws_rds_cluster_parameter_group" "aurora_cluster_parameter_group" {
  name   = var.pg_name
  family = var.family
}
