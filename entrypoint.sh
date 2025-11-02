#!/bin/bash
set -e

# كتابة ملف odoo.conf
cat > /etc/odoo/odoo.conf << EOF
[options]
addons_path = /mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons
admin_passwd = ${ADMIN_PASSWD:-admin}
db_host = ${PGHOST}
db_port = ${PGPORT:-5432}
db_user = ${PGUSER}
db_password = ${PGPASSWORD}
http_port = 8069
proxy_mode = True
list_db = True
EOF

# تشغيل Odoo بدون تحقق من postgres user
exec python3 -c "import sys; sys.argv = ['odoo', '-c', '/etc/odoo/odoo.conf']; import odoo; odoo.cli.main()"
