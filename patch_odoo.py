#!/usr/bin/env python3
import os

# ملف الكود اللي فيه الفحص
odoo_service_file = '/usr/lib/python3/dist-packages/odoo/service/db.py'

# قراءة الملف
with open(odoo_service_file, 'r') as f:
    content = f.read()

# إزالة الفحص على postgres user
content = content.replace(
    "if db_user == 'postgres':",
    "if False:"  # تعطيل الفحص
)

# حفظ الملف
with open(odoo_service_file, 'w') as f:
    f.write(content)

print("Odoo patched successfully!")
