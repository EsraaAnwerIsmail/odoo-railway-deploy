#!/bin/bash
set -e

echo "Starting Odoo..."

# كتابة ملف odoo.conf
cat > /etc/odoo/odoo.conf << EOF
[options]
addons_path = /mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons
admin_passwd = ${ADMIN_PASSWD:-admin}
db_host = ${PGHOST}
db_port = ${PGPORT:-5432}
db_user = ${PGUSER}
db_password = ${PGPASSWORD}
db_name = False
http_port = 8069
proxy_mode = True
db_maxconn = 64
limit_time_cpu = 600
limit_time_real = 1200
list_db = True
EOF

echo "Starting Odoo with config..."
exec odoo -c /etc/odoo/odoo.conf
