//--------------------------------------------------------------------
// Modules
//--------------------------------------------------------------------

######
# VPC
######
module "vpc" {
  source = "app.terraform.io/megazonesa/vpc/aws"
  version = "2.48.0"
  
  database_subnets    =  var.database_subnets

  create_database_subnet_group           = true
  create_database_subnet_route_table     = true

  database_subnet_group_tags = var.database_subnet_group_tags
}


#####
# DB
#####
#module "db" {
#  source = "app.terraform.io/megazonesa/rds/aws"
#  version = "~> 2.0"
#
#  identifier = var.identifier
#
#  # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
#  engine            = "mysql"
#  engine_version    = var.engin_version
#  instance_class    = var.instance_class
#  allocated_storage = var.allocated_storage
#  storage_encrypted = false
#
#  name     = var.name
#  username = var.username
#  password = var.password
#  port     = "3306"
#
#  vpc_security_group_ids = [data.aws_security_group.default.id]
#
#  multi_az = var.maulti_az
#
#  # disable backups to create DB faster
#  backup_retention_period = "7"
#  maintenance_window = "Mon:00:00-Mon:03:00"
#  backup_window      = "03:00-06:00"
#
#  tags = var.tags
#
#  # DB subnet group
#  #subnet_ids =  data.aws_subnet_ids.all.ids
#  subnet_ids =  module.vpc.aws_subnet_ids.all.ids
#
#  # DB parameter group
#  family = var.family
#
#  # DB option group
#  major_engine_version = var.major_engine_version
#
#  # Snapshot name upon DB deletion
#  final_snapshot_identifier = var.final_snapshot_identifier
#
#  # Database Deletion Protection
#  deletion_protection = var.deletion_protection
#
#  parameters = [
#    {
#      name  = "character_set_client"
#      value = "utf8"
#    },
#    {
#      name  = "character_set_server"
#      value = "utf8"
#    }
#  ]
#
#  options = [
#    {
#      option_name = "MARIADB_AUDIT_PLUGIN"
#
#      option_settings = [
#        {
#          name  = "SERVER_AUDIT_EVENTS"
#          value = "CONNECT"
#        },
#        {
#          name  = "SERVER_AUDIT_FILE_ROTATIONS"
#          value = "37"
#        },
#      ]
#    },
#  ]
#}
