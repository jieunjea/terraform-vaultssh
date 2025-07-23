# search for existing VPCs in AWS
data "aws_vpcs" "existing" {}

# Select the first VPC from the list of existing VPCs
data "aws_vpc" "existing" {
  id = data.aws_vpcs.existing.ids[0]
}

data "aws_subnets" "existing" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing.id]
  }
  filter {
    name   = "map-public-ip-on-launch"
    values = ["true"]
  }
}

# Search for existing security groups in AWS
data "aws_security_group" "vault" {
  id = var.aws_security_group
}