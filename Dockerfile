FROM odoo:17.0

USER root

# تثبيت postgresql-client
RUN apt-get update && apt-get install -y postgresql-client && rm -rf /var/lib/apt/lists/*

# نسخ الموديولات المخصصة
COPY ./custom_addons /mnt/extra-addons/

# نسخ patch script
COPY ./patch_odoo.py /patch_odoo.py
RUN chmod +x /patch_odoo.py

# تطبيق الـ patch
RUN python3 /patch_odoo.py

# نسخ entrypoint script
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# تثبيت المكتبات الإضافية
RUN pip3 install --no-cache-dir xlsxwriter

# الرجوع لمستخدم odoo
USER odoo

# استخدام الـ entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
