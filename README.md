# Terraform Vault SSH Helper Deployment

This repository provides an automated Terraform configuration to deploy and configure the Vault SSH Secrets Engine with `vault-ssh-helper`.  
It allows users to connect to EC2 instances via SSH using Vault-issued OTPs.

---

## Components

- **Terraform**: Used to provision AWS infrastructure and Vault configurations
- **HashiCorp Vault OSS**: SSH secrets engine for one-time password-based SSH access

---

## What This Terraform Configuration Deploys

- A dedicated Vault namespace
- An enabled and configured SSH Secrets Engine
- A Vault SSH role for OTP access
- An EC2 instance as the SSH target
- `vault-ssh-helper` installed and configured via user data

---

## Architecture Overview
### Terraform Architecture

### Vault Workflow
<img width="882" height="316" alt="image" src="https://github.com/user-attachments/assets/afa6c5bb-486f-446f-9b79-53b24f3fb27f" />

"Why OTP-based SSH?"
This approach eliminates the need to manage persistent SSH keys and provides time-limited, auditable access to critical infrastructure.
