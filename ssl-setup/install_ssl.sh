#!/bin/bash

# دریافت ورودی‌های دامنه و ساب دامنه
DOMAIN=$1
SUBDOMAIN=$2

# نصب Certbot و Let's Encrypt
sudo apt update
sudo apt install -y certbot python3-certbot-apache

# دریافت و نصب SSL برای دامنه اصلی و ساب‌دامنه‌ها
if [ ! -z "$SUBDOMAIN" ]; then
    sudo certbot --apache -d $DOMAIN -d www.$DOMAIN -d $SUBDOMAIN
else
    sudo certbot --apache -d $DOMAIN -d www.$DOMAIN
fi

# تنظیم تمدید خودکار SSL
echo "0 0 * * * root certbot renew --quiet" | sudo tee -a /etc/crontab > /dev/null

echo "SSL برای دامنه شما تنظیم و تمدید خودکار فعال شد."
