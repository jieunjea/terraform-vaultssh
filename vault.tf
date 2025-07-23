# Vault SSH Secrets Backend Configuration
resource "vault_mount" "ssh_secrets" {
  path      = "ssh"
  type      = "ssh"
  options = {
    default_lease_ttl = "1h"
    max_lease_ttl     = "24h"
  }
  depends_on = [vault_namespace.namespace]
}

# Create a role for OTP SSH access
resource "vault_ssh_secret_backend_role" "otp_role" {
    name          = "otp-role"
    namespace     = vault_namespace.namespace.path
    backend       = vault_mount.ssh_secrets.path
    key_type      = "otp"
    default_user  = "ec2-user"
    cidr_list     = "0.0.0.0/0"
}
