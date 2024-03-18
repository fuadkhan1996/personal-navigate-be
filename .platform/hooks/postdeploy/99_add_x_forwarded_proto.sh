#!/bin/bash

# Append the proxy_set_header directive to the Nginx configuration
if ! grep -q "proxy_set_header X-Forwarded-Proto" /etc/nginx/nginx.conf; then
    echo "Adding X-Forwarded-Proto header to Nginx config"
    # Use sed or echo commands to modify nginx.conf or specific files within conf.d
    sed -i '/location @proxy {/a \    proxy_set_header X-Forwarded-Proto \$scheme;' /etc/nginx/conf.d/webapp.conf
    systemctl restart nginx
fi
