#!/bin/bash
# Installs a lightweight web server showing the instance hostname.
# Refreshing the ALB URL repeatedly shows load distribution across instances.

dnf update -y
dnf install -y nginx
systemctl enable --now nginx

HOST=$(hostname)
ZONE=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone 2>/dev/null || echo "unknown")
cat > /usr/share/nginx/html/index.html <<EOF
<h1>Terraform Cloud Project</h1>
<p>Host: ${HOST}</p>
<p>AZ: ${ZONE}</p>
EOF
