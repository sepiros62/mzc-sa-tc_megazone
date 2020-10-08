// -------
// ALB
// -------

variable "name" {
  description = "The resource name and Name tag of the load balancer."
  type        = string
  default     = null
}

variable "target_groups" {
  description = "A list of maps containing key/value pairs that define the target groups to be created. Order of these maps is important and the index of these are to be referenced in listener definitions. Required key/values: name, backend_protocol, backend_port"
  type        = any
  default     = []
}

variable "path" {
  description = ""
  type        = string
  default     = "/"
}

variable "name_prefix" {
  description = "The resource name prefix and Name tag of the load balancer. Cannot be longer than 6 characters"
  type        = string
  default     = null
}

variable "healthy_threshold" {
  description = ""
  type        = string
  default     = "5"
}

variable "unhealthy_threshold" {
  description = ""
  type        = string
  default     = "2"
}

variable "timeout" {
  description = ""
  type        = string
  default     = "5"
}

variable "matcher" {
  description = ""
  type        = string
  default     = "200"
}

variable "lb_tags" {
  description = "A map of tags to add to load balancer"
  type        = map(string)
  default     = {}
}

variable "target_group_tags" {
  description = "A map of tags to add to all target groups"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}