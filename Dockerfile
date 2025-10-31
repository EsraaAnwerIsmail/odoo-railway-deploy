FROM odoo:17.0

USER root

# نسخ الموديولات المخصصة
COPY ./custom_addons /mnt/extra-addons/

# تثبيت المكتبات الإضافية
RUN pip3 install --no-cache-dir xlsxwriter

# الرجوع لمستخدم odoo
USER odoo

# تشغيل Odoo
CMD ["odoo"]
