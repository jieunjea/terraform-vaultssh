#!/bin/bash
set -e

# 필요한 도구 설치
dnf update -y
dnf install -y wget unzip

# 1. vault-ssh-helper 다운로드 및 설치
wget https://releases.hashicorp.com/vault-ssh-helper/0.2.1/vault-ssh-helper_0.2.1_linux_amd64.zip
unzip -q vault-ssh-helper_0.2.1_linux_amd64.zip -d /usr/local/bin
chmod 0755 /usr/local/bin/vault-ssh-helper
chown root:root /usr/local/bin/vault-ssh-helper

# 2. 설정 디렉토리 생성 및 config 파일 작성
mkdir -p /etc/vault-ssh-helper.d
cat <<EOF > /etc/vault-ssh-helper.d/config.hcl
vault_addr = "${VAULT_ADDR}"
tls_skip_verify = true
ssh_mount_point = "ssh"
namespace = "${VAULT_NAMESPACE}"
allowed_roles = "*"
allowed_cidr_list = "0.0.0.0/0"
EOF

# 3. sshd_config 수정
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.orig
cp /etc/ssh/sshd_config.d/50-redhat.conf /etc/ssh/50-redhat.orig

sed -i '/^#*PasswordAuthentication/d' /etc/ssh/sshd_config
sed -i '/^#*ChallengeResponseAuthentication/d' /etc/ssh/sshd_config.d/50-redhat.conf
sed -i '/^#*UsePAM/d' /etc/ssh/sshd_config.d/50-redhat.conf
sed -i '/^#*UsePAM/d' /etc/ssh/sshd_config
sed -i '/^#*KbdInteractiveAuthentication/d' /etc/ssh/sshd_config

echo "KbdInteractiveAuthentication yes" >> /etc/ssh/sshd_config
echo "UsePAM yes" >> /etc/ssh/sshd_config.d/50-redhat.conf
echo "UsePAM yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
echo "ChallengeResponseAuthentication yes" >> /etc/ssh/sshd_config.d/50-redhat.conf

# 4. /etc/pam.d/sshd 수정
cp /etc/pam.d/sshd /etc/pam.d/sshd.bak

cat <<EOF > /etc/pam.d/sshd
#%PAM-1.0
#auth       substack     password-auth
auth       include      postlogin
account    required     pam_sepermit.so
account    required     pam_nologin.so
account    include      password-auth
#password   include      password-auth
auth requisite pam_exec.so quiet expose_authtok log=/var/log/vault-ssh.log /usr/local/bin/vault-ssh-helper -config=/etc/vault-ssh-helper.d/config.hcl -dev
auth optional pam_unix.so not_set_pass use_first_pass nodelay
# pam_selinux.so close should be the first session rule
session    required     pam_selinux.so close
session    required     pam_loginuid.so
# pam_selinux.so open should only be followed by sessions to be executed in the user context
session    required     pam_selinux.so open env_params
session    required     pam_namespace.so
session    optional     pam_keyinit.so force revoke
session    optional     pam_motd.so
session    include      password-auth
session    include      postlogin
EOF

# 5. sshd 재시작
systemctl restart sshd

# 6. vault-ssh-helper 설정 검증 로그
vault-ssh-helper -verify-only -dev -config /etc/vault-ssh-helper.d/config.hcl > /var/log/vault-ssh-verify.log 2>&1