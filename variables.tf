variable "name" {
  description = "Environment name"
}

variable "instance_type" {
  description = "AWS instance type to assign"
}

variable "automatic_stop_time_minutes" {
  description = "Minutes of inactivity before the instance is shut down"
  default     = 30
}

variable "description" {
  description = "Description of the environment"
}

variable "owner_arn" {
  description = "ARN of the environment owner"
}

variable "subnet_type" {
  description = "Subnet type (e.g., 'campus', 'private', 'public') for resource placement"
}

variable "tags" {
  description = "Mapping of tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "vpc" {
  description = "Name of VPC for resource placement"
}
