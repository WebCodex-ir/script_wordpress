#!/bin/bash

# نصب LiteSpeed Cache
sudo apt update
sudo apt install -y lscache

# فعال‌سازی کش برای وردپرس
sudo bash -c 'cat > /var/www/$DOMAIN/public_html/wp-content/plugins/litespeed-cache/lscache.conf <<EOF
# تنظیمات LiteSpeed Cache برای وردپرس
EOF'

# راه‌اندازی مجدد سرویس
sudo systemctl restart apache2

echo "LiteSpeed Cache با موفقیت فعال شد."
