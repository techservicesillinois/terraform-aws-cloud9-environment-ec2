data "aws_availability_zones" "selected" {}

data "aws_vpc" "selected" {
  tags = {
    Name = var.vpc
  }
}

data "aws_subnet" "selected" {
  vpc_id = data.aws_vpc.selected.id

  filter {
    name   = "availability-zone"
    values = [local.az]
  }

  tags = {
    Tier = var.tier
  }
}

locals {
  az        = sort(data.aws_availability_zones.selected.names)[0]
  subnet_id = data.aws_subnet.selected.id
}

resource "aws_cloud9_environment_ec2" "default" {
  name                        = var.name
  instance_type               = var.instance_type
  automatic_stop_time_minutes = var.automatic_stop_time_minutes
  description                 = var.description
  owner_arn                   = var.owner_arn
  subnet_id                   = local.subnet_id
}
