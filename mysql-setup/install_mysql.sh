#!/bin/bash

# دریافت ورودی‌های MySQL
DB_USER=$1
DB_PASS=$2

# نصب MySQL
sudo apt update
sudo apt install -y mysql-server

# راه‌اندازی MySQL
sudo systemctl enable mysql
sudo systemctl start mysql

# ساخت دیتابیس وردپرس
sudo mysql -u root -e "CREATE DATABASE wordpress;"

# ساخت کاربر و اعطای دسترسی‌ها
sudo mysql -u root -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';"
sudo mysql -u root -e "GRANT ALL PRIVILEGES ON wordpress.* TO '$DB_USER'@'localhost';"
sudo mysql -u root -e "FLUSH PRIVILEGES;"

echo "دیتابیس و کاربر MySQL با موفقیت ایجاد شد."
