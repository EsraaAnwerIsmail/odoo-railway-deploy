#!/bin/bash
set -e

# السماح باستخدام postgres user
export ALLOW_ADMIN_USER=True

# تشغيل Odoo مع المتغيرات البيئية
exec odoo \
  --addons-path=/mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons \
  --db_host=${PGHOST} \
  --db_port=${PGPORT:-5432} \
  --db_user=${PGUSER} \
  --db_password=${PGPASSWORD} \
  --http-port=8069 \
  --proxy-mode \
  --no-database-list
