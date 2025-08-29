#!/bin/bash

# سوالاتی که از کاربر میپرسیم
echo "این اسکریپت به طور خودکار تنظیمات سرور را انجام می‌دهد."

read -p "دامنه اصلی خود را وارد کنید (مثال: example.com): " DOMAIN
read -p "آیا ساب‌دامنه دارید؟ (اگر ندارید Enter را بزنید): " SUBDOMAIN
read -p "نام کاربری دیتابیس MySQL را وارد کنید: " DB_USER
read -p "رمز عبور دیتابیس MySQL را وارد کنید: " DB_PASS

# دانلود اسکریپت‌ها از گیت‌هاب و تنظیم
echo "گرفتن فایل‌ها از گیت‌هاب..."
git clone https://github.com/your-username/your-repo.git
cd your-repo

# اجرای اسکریپت‌های نصب و تنظیم
bash apache-setup/install_apache.sh "$DOMAIN" "$SUBDOMAIN"
bash wordpress-setup/install_wordpress.sh "$DOMAIN" "$DB_USER" "$DB_PASS"
bash mysql-setup/install_mysql.sh "$DB_USER" "$DB_PASS"
bash ftp-setup/install_ftp.sh
bash ssl-setup/install_ssl.sh "$DOMAIN" "$SUBDOMAIN"
bash lscache-setup/install_lscache.sh "$DOMAIN"

echo "همه مراحل با موفقیت انجام شد!"
