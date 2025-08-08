data "aws_ami" "al2023" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Amazon
}

# Terraform Configuration for AWS EC2 Instance with Vault SSH Secrets Engine
resource "aws_instance" "ec2_instance" {
  ami                         = data.aws_ami.al2023.id
  instance_type               = var.instance_type
  key_name                    = var.prefix
  associate_public_ip_address = true
  vpc_security_group_ids      = [data.aws_security_group.vault.id]
  user_data = templatefile("userdata.sh", {
  VAULT_ADDR      = var.VAULT_ADDR,
})

  tags = {
    Name = "${var.prefix}-terraform-instance"
  }
}