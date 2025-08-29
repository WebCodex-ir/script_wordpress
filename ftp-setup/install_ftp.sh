#!/bin/bash

# نصب سرویس FTP
sudo apt update
sudo apt install -y vsftpd

# فعال‌سازی vsftpd
sudo systemctl enable vsftpd
sudo systemctl start vsftpd

# تنظیمات امنیتی FTP
sudo bash -c 'cat > /etc/vsftpd.conf <<EOF
listen=YES
anonymous_enable=NO
local_enable=YES
write_enable=YES
chroot_local_user=YES
EOF'

# راه‌اندازی مجدد سرویس FTP
sudo systemctl restart vsftpd
