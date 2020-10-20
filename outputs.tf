output "ids" {
  description = "List of IDs of instances"
  value       = module.ec2_cluster.id
}

output "ids_t2" {
  description = "List of IDs of t2-type instances"
  value       = module.ec2_cluster_with_t2_unlimited.id
}

output "public_dns" {
  description = "List of public DNS names assigned to the instances"
  value       = module.ec2_cluster.public_dns
}

output "vpc_security_group_ids" {
  description = "List of VPC security group ids assigned to the instances"
  value       = module.ec2_cluster.vpc_security_group_ids
}

output "root_block_device_volume_ids" {
  description = "List of volume IDs of root block devices of instances"
  value       = module.ec2_cluster.root_block_device_volume_ids
}

output "ebs_block_device_volume_ids" {
  description = "List of volume IDs of EBS block devices of instances"
  value       = module.ec2_cluster.ebs_block_device_volume_ids
}

output "tags" {
  description = "List of tags"
  value       = module.ec2_cluster.tags
}

output "placement_group" {
  description = "List of placement group"
  value       = module.ec2_cluster.placement_group
}

output "instance_id" {
  description = "ec2_cluster instance ID"
  value       = module.ec2_cluster.id[0]
}

output "t2_instance_id" {
  description = "ec2_cluster instance ID"
  value       = module.ec2_cluster_with_t2_unlimited.id[0]
}

output "instance_public_dns" {
  description = "Public DNS name assigned to the ec2_cluster instance"
  value       = module.ec2_cluster.public_dns[0]
}

output "credit_specification" {
  description = "Credit specification of ec2_cluster instance (empty list for not t2 instance types)"
  value       = module.ec2_cluster.credit_specification
}

output "credit_specification_t2_unlimited" {
  description = "Credit specification of t2-type ec2_cluster instance"
  value       = module.ec2_cluster_with_t2_unlimited.credit_specification
}