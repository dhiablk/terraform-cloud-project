#!/bin/bash
# Installs a lightweight web server showing the instance hostname.
# Refreshing the ALB URL repeatedly shows load distribution across instances.
# NOTE: uses apt (Canonical Ubuntu AMI) because AWS Academy denies
# ec2:DescribeImages, preventing dynamic AL2023 AMI lookup.

apt-get update -y
apt-get install -y nginx
systemctl enable --now nginx

HOST=$(hostname)
cat > /var/www/html/index.html <<EOF
<h1>Terraform Cloud Project</h1>
<p>Host: ${HOST}</p>
EOF
