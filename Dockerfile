FROM odoo:17.0

USER root

# نسخ الموديولات المخصصة
COPY ./custom_addons /mnt/extra-addons/

# تثبيت المكتبات الإضافية
RUN pip3 install --no-cache-dir xlsxwriter

# الرجوع لمستخدم odoo
USER odoo

# تشغيل Odoo مع المتغيرات البيئية
CMD ["odoo", "--addons-path=/mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons", "--db_host=$PGHOST", "--db_port=$PGPORT", "--db_user=$PGUSER", "--db_password=$PGPASSWORD"]
