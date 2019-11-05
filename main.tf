data "aws_vpc" "selected" {
  tags = {
    Name = var.vpc
  }
}

data "aws_subnet_ids" "selected" {
  vpc_id = data.aws_vpc.selected.id

  tags = {
    Tier = var.tier
  }
}

locals {
  subnet_id = tolist(data.aws_subnet_ids.selected.ids)[0]
}

resource "aws_cloud9_environment_ec2" "default" {
  name                        = var.name
  instance_type               = var.instance_type
  automatic_stop_time_minutes = var.automatic_stop_time_minutes
  description                 = var.description
  owner_arn                   = var.owner_arn
  subnet_id                   = local.subnet_id
}
