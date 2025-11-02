#!/bin/bash
set -e

echo "Patching Odoo to allow postgres user..."

# البحث عن الملف اللي فيه الفحص
ODOO_DB_FILE="/usr/lib/python3/dist-packages/odoo/service/db.py"

if [ -f "$ODOO_DB_FILE" ]; then
    # عمل backup
    cp "$ODOO_DB_FILE" "${ODOO_DB_FILE}.backup"
    
    # إزالة الفحص
    sed -i "s/if cursor.fetchone\(\)\[0\] == 'postgres':/if False and cursor.fetchone()[0] == 'postgres':/" "$ODOO_DB_FILE"
    sed -i "s/if db_user == 'postgres':/if False:/" "$ODOO_DB_FILE"
    
    echo "✓ Patch applied successfully!"
else
    echo "✗ File not found: $ODOO_DB_FILE"
fi
