# Terraform Vault SSH Helper Deployment

This repository provides an automated Terraform configuration to deploy and configure the Vault SSH Secrets Engine with `vault-ssh-helper`.  
It allows users to connect to EC2 instances via SSH using Vault-issued OTPs.

---

## Components

- **Terraform**: Used to provision AWS infrastructure and Vault configurations
- **HashiCorp Vault OSS**: SSH secrets engine for one-time password-based SSH access
- **vault-ssh-helper**: Enables PAM-based SSH login via Vault OTP
- **Amazon EC2**: Target for SSH login
- **AWS SSM**: (Optional) for secure parameter storage

---

## Architecture Overview
