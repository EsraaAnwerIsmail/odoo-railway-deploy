FROM odoo:16.0

USER root

# نسخ الموديولات المخصصة
COPY ./custom_addons /mnt/extra-addons/

# نسخ entrypoint script
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# تثبيت المكتبات الإضافية
RUN pip3 install --no-cache-dir xlsxwriter

# الرجوع لمستخدم odoo
USER odoo

# استخدام الـ entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
