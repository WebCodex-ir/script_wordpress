#!/bin/bash

# دریافت ورودی‌های دامنه و دیتابیس
DOMAIN=$1
DB_USER=$2
DB_PASS=$3

# نصب نیازمندی‌های وردپرس
sudo apt install -y php libapache2-mod-php php-mysql php-curl php-json php-xml php-mbstring php-zip unzip wget

# دانلود و نصب وردپرس
cd /var/www/$DOMAIN/public_html
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
mv wordpress/* .
rm -rf wordpress
rm latest.tar.gz

# تنظیمات دسترسی به فایل‌ها
sudo chown -R www-data:www-data /var/www/$DOMAIN/public_html
sudo chmod -R 755 /var/www/$DOMAIN/public_html

# پیکربندی wp-config.php برای دیتابیس
cp /var/www/$DOMAIN/public_html/wp-config-sample.php /var/www/$DOMAIN/public_html/wp-config.php
sudo sed -i "s/database_name_here/wordpress/" /var/www/$DOMAIN/public_html/wp-config.php
sudo sed -i "s/username_here/$DB_USER/" /var/www/$DOMAIN/public_html/wp-config.php
sudo sed -i "s/password_here/$DB_PASS/" /var/www/$DOMAIN/public_html/wp-config.php

echo "وردپرس با موفقیت نصب و پیکربندی شد."
