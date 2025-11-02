FROM odoo:17.0

USER root

# نسخ الموديولات المخصصة
COPY ./custom_addons /mnt/extra-addons/

# نسخ patch script
COPY ./fix_postgres_check.sh /fix_postgres_check.sh
RUN chmod +x /fix_postgres_check.sh

# تطبيق الـ patch
RUN /fix_postgres_check.sh

# نسخ entrypoint script
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# تثبيت المكتبات الإضافية
RUN pip3 install --no-cache-dir xlsxwriter

# الرجوع لمستخدم odoo
USER odoo

# استخدام الـ entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
