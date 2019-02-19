variable "name" {
  description = "The name of the environment"
}

variable "instance_type" {
  description = "The type of instance to connect to the environment"
  default     = "t2.nano"
}

variable "automatic_stop_time_minutes" {
  description = "Minutes until the instance is shut down after inactivity"
  default     = 30
}

variable "description" {
  description = "The description of the environment"
}

variable "owner_arn" {
  description = "The ARN of the environment owner"
}

variable "vpc" {
  description = "VPC in which EC2 instance is to be placed"
}

variable "tier" {
  description = "Network tier in which to place EC2 instance"
  default     = "public"
}
