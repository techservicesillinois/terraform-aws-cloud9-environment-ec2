# cloud9-environment-ec2

[![Build Status](https://drone.techservices.illinois.edu/api/badges/techservicesillinois/terraform-aws-cloud9-environment-ec2/status.svg)](https://drone.techservices.illinois.edu/techservicesillinois/terraform-aws-cloud9-environment-ec2)

Provides a Cloud9 EC2 Development Environment.

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
  vpc         = "vpcName"

  owner_arn = "arn:aws:sts::917683843710:assumed-role/roleName/netid@illinois.edu"
```

Argument Reference
-----------------

The following arguments are supported:

* `name` - (Required) The name of the environment.

* `description` - (Required) The description of the environment.

* `owner_arn` - (Required) The ARN of the environment owner.

* `vpc` - (Required) VPC in which EC2 instance is to be placed.

* `tier` - (Optional) Network tier in which to place EC2 instance (default public).

* `instance_type` - (Optional) The type of instance to connect to the environment (default t2.nano).

* `automatic_stop_time_minutes` - (Optional) Minutes until the instance is shut down after inactivity (default 30).

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
