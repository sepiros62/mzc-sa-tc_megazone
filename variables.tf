// -------
// AutoScaling
// -------
variable "name" {
  description = "Creates a unique name beginning with the specified prefix"
  type        = string
}

variable "lc_name" {
  description = "Creates a unique name for launch configuration beginning with the specified prefix"
  type        = string
  default     = ""
}

variable "asg_name" {
  description = "Creates a unique name for autoscaling group beginning with the specified prefix"
  type        = string
  default     = ""
}

variable "create_lc" {
  description = "Whether to create launch configuration"
  type        = bool
  default     = true
}

variable "instance_type" {
  description = "The size of instance to launch"
  type        = string
  default     = ""
}

variable "desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  type        = string
}

variable "min_size" {
  description = "The minimum size of the auto scale group"
  type        = string
}

variable "max_size" {
  description = "The maximum size of the auto scale group"
  type        = string
}

variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch."
  type        = list(map(string))
  default     = []
}