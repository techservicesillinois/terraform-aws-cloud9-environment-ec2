# Choose a single random availability zone from map of AZs matching
# the specified subnet_type.

resource "random_shuffle" "az" {
  input        = keys(module.get-subnets.subnets_by_az)
  result_count = 1
}

module "get-subnets" {
  source = "github.com/techservicesillinois/terraform-aws-util//modules/get-subnets?ref=v3.0.5"

  include_subnets_by_az = true
  subnet_type           = var.subnet_type
  vpc                   = var.vpc
}

locals {
  availability_zone = random_shuffle.az.result[0]
  subnet_id         = module.get-subnets.subnets_by_az[local.availability_zone][0]
}

resource "aws_cloud9_environment_ec2" "default" {
  name                        = var.name
  instance_type               = var.instance_type
  automatic_stop_time_minutes = var.automatic_stop_time_minutes
  description                 = var.description
  owner_arn                   = var.owner_arn
  subnet_id                   = local.subnet_id
  # Tag cannot have the key 'Name' as it is a reserved key by EC2.
  # tags                      = merge({ "Name" = var.name }, var.tags)
  tags = var.tags
}
