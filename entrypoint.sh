#!/bin/bash
set -e

echo "Starting Odoo entrypoint..."

# إنشاء odoo user في PostgreSQL إذا لم يكن موجوداً
echo "Creating odoo database user..."
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -p $PGPORT -U $PGUSER -d postgres -tc "SELECT 1 FROM pg_user WHERE usename = 'odoo'" | grep -q 1 || \
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -p $PGPORT -U $PGUSER -d postgres -c "CREATE USER odoo WITH PASSWORD '$PGPASSWORD' CREATEDB;"

# منح صلاحيات لـ odoo user
echo "Granting permissions..."
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -p $PGPORT -U $PGUSER -d postgres -c "ALTER USER odoo CREATEDB;"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -p $PGPORT -U $PGUSER -d postgres -c "GRANT ALL PRIVILEGES ON DATABASE $PGDATABASE TO odoo;" || true

# كتابة ملف odoo.conf
echo "Writing odoo.conf..."
cat > /etc/odoo/odoo.conf << EOF
[options]
addons_path = /mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons
admin_passwd = ${ADMIN_PASSWD:-admin}
db_host = ${PGHOST}
db_port = ${PGPORT:-5432}
db_user = odoo
db_password = ${PGPASSWORD}
db_name = False
http_port = 8069
proxy_mode = True
db_maxconn = 64
limit_time_cpu = 600
limit_time_real = 1200
list_db = True
EOF

echo "Starting Odoo..."
exec odoo -c /etc/odoo/odoo.conf
