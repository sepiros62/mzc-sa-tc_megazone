// -------
// EC2
// -------
variable "name" {
  description = "Name to be used on all resources as prefix"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}


// -----------------
// Security Group
// -----------------
variable "ingress_cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all ingress rules"
  type        = list(string)
  default     = []
}