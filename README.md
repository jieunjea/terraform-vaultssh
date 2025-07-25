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
### Vault Workflow
<img width="882" height="316" alt="image" src="https://github.com/user-attachments/assets/afa6c5bb-486f-446f-9b79-53b24f3fb27f" />
