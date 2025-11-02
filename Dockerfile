FROM odoo:17.0

USER root

# نسخ الموديولات المخصصة
COPY ./custom_addons /mnt/extra-addons/

# نسخ Python wrapper
COPY ./odoo_wrapper.py /usr/local/bin/odoo_wrapper.py
RUN chmod +x /usr/local/bin/odoo_wrapper.py

# نسخ entrypoint script
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# تثبيت المكتبات الإضافية
RUN pip3 install --no-cache-dir xlsxwriter

# الرجوع لمستخدم odoo
USER odoo

# استخدام الـ entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
