# cloud9-environment-ec2

[![Terraform actions status](https://github.com/techservicesillinois/terraform-aws-cloud9-environment-ec2/workflows/terraform/badge.svg)](https://github.com/techservicesillinois/terraform-aws-cloud9-environment-ec2/actions)

Provides a Cloud9 EC2 development environment.

Example Usage
-----------------

The following example creates a Cloud9 EC2 environment in VPC
`vpcName` in the lexicographically smallest availability zone (AZ)
available in the given VPC. For a VPC using all AZs in us-east-2
that would be `us-east-2a`.

```
module "service_name" {
  source = "git@github.com:techservicesillinois/terraform-aws-cloud9-environment-ec2"

  name        = "service"
  description = "Environment for service development"
  subnet_type = "public"
  vpc         = "vpcName"

  owner_arn = "arn:aws:sts::917683843710:assumed-role/roleName/netid@illinois.edu"
```

Argument Reference
-----------------

The following arguments are supported:

* `automatic_stop_time_minutes` - (Optional) Minutes until the instance is shut down after inactivity (default 30).

* `name` - (Required) The name of the environment.

* `description` - (Required) The description of the environment.

* `instance_type` - (Required) The type of instance to connect to the environment.nano).

* `owner_arn` - (Required) The ARN of the environment owner.

* `subnet_type` - (Required) Subnet type (e.g., 'campus', 'private', 'public') for resource placement.

* `vpc` - (Required) Name of the virtual private cloud in which resources are to be placed.

Attributes Reference
--------------------

The following attributes are exported:

* `id` - The ID of the environment.

* `arn` - The ARN of the environment.

* `type` - The type of the environment (e.g. ssh or ec2).

Limitations
-----------

* The subnet where the EC2 instance resides can not be specified.

* The selected VPC must have at most one subnet per availability zone (AZ).
