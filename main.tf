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


#####
# DB
#####
module "db" {
  source  = "app.terraform.io/MEGAZONE-prod/rds/aws"
  version = "1.0.0"

  identifier = var.identifier

  # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
  engine            = "mysql"
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  storage_encrypted = false

  name     = var.name
  username = var.username
  password = var.password
  port     = "3306"

  vpc_security_group_ids = [data.aws_security_group.default.id]

  multi_az = var.multi_az

  # disable backups to create DB faster
  backup_retention_period = "7"
  backup_window           = "03:00-06:00"
  maintenance_window = "Mon:00:00-Mon:03:00"
  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  tags = var.tags

  # DB subnet group
  subnet_ids = data.aws_subnet_ids.all.ids

  # DB parameter group
  family = var.family

  # DB option group
  major_engine_version = var.major_engine_version

  # Snapshot name upon DB deletion
  final_snapshot_identifier = var.final_snapshot_identifier

  # Database Deletion Protection
  deletion_protection = var.deletion_protection

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8"
    },
    {
      name  = "character_set_server"
      value = "utf8"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}
