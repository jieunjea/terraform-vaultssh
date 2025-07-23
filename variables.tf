##############################################################################
# Variables File
#
# Here is where we store the default values for all the variables used in our
# Terraform code. If you create a variable with no default, the user will be
# prompted to enter it (or define it via config file or command line flags.)

variable "prefix" {
  description = "This prefix will be included in the name of most resources."
  default     = "JE"
}

variable "AWS_ACCESS_KEY_ID" {
  description = "AWS Access Key"
  type        = string
  sensitive   = true
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS Secret Key"
  type        = string
  sensitive   = true
}
variable "aws_region" {
  description = "The region where the resources are created."
  default     = "ap-northeast-3"
}

variable "instance_type" {
  description = "The instance type what use in aws region."
  default = "t2.micro"
}

variable "aws_security_group" {
  description = "The security group to use for the instance."
  default     = "default"
  
}

variable "VAULT_ADDR" {
  description = "The address for vault cluster."
}

variable "VAULT_TOKEN" {
  description = "The token for vault cluster."
}

