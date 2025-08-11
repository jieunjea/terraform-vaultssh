# Terraform Deployment for HashiCorp Vault SSH Helper

## Overview
This project automates the deployment and configuration of the **HashiCorp Vault SSH Helper** on AWS EC2 instances using Terraform.  
By integrating Vault's secrets management with SSH authentication, it enables **dynamic SSH access control** and strengthens overall security.

## Features
- **Automated EC2 provisioning** using Terraform
- **Installation and configuration** of `vault-ssh-helper` for secure SSH access
- **Vault Namespace** creation and **SSH Secrets Engine** configuration
- **Dynamic, role-based SSH access control** using Vault policies and OTP authentication

## Prerequisites
- An AWS account with permissions for EC2, IAM, and VPC resources
- Access to a **HashiCorp Vault Enterprise** server (address and token required)
- Terraform installed locally (**v1.0+ recommended**)
- Basic understanding of Vault policies and SSH authentication
