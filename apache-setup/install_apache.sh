#!/bin/bash

# دریافت ورودی‌های دامنه و ساب دامنه
DOMAIN=$1
SUBDOMAIN=$2

# نصب Apache
sudo apt update
sudo apt install -y apache2

# فعال‌سازی و راه‌اندازی Apache
sudo systemctl enable apache2
sudo systemctl start apache2

# تنظیمات Virtual Hosts برای دامنه اصلی
sudo bash -c "cat > /etc/apache2/sites-available/$DOMAIN.conf <<EOF
<VirtualHost *:80>
    ServerAdmin webmaster@$DOMAIN
    ServerName $DOMAIN
    DocumentRoot /var/www/$DOMAIN/public_html
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF"

# تنظیمات برای ساب‌دامنه (اگر وجود داشته باشد)
if [ ! -z "$SUBDOMAIN" ]; then
  sudo bash -c "cat > /etc/apache2/sites-available/$SUBDOMAIN.conf <<EOF
<VirtualHost *:80>
    ServerAdmin webmaster@$SUBDOMAIN
    ServerName $SUBDOMAIN
    DocumentRoot /var/www/$SUBDOMAIN/public_html
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF"
  # فعال‌سازی ساب‌دامنه
  sudo a2ensite $SUBDOMAIN.conf
fi

# فعال‌سازی دامنه اصلی
sudo a2ensite $DOMAIN.conf

# بهبود سرعت و امنیت Apache
sudo bash -c "cat > /etc/apache2/conf-available/security.conf <<EOF
ServerTokens Prod
ServerSignature Off
TraceEnable Off
EOF"

# نصب و تنظیم SSL برای امنیت بیشتر
sudo apt install -y ufw
sudo ufw allow OpenSSH
sudo ufw allow 80,443/tcp
sudo ufw enable

# ریستارت Apache برای اعمال تغییرات
sudo systemctl restart apache2
