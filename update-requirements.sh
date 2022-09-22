#!/bin/bash
wget -O requirements3-odoo12.txt https://raw.githubusercontent.com/odoo/odoo/12.0/requirements.txt
wget -O requirements3-odoo13.txt https://raw.githubusercontent.com/odoo/odoo/13.0/requirements.txt
wget -O requirements3-odoo14.txt https://raw.githubusercontent.com/odoo/odoo/14.0/requirements.txt
wget -O requirements3-odoo15.txt https://raw.githubusercontent.com/odoo/odoo/15.0/requirements.txt
wget -O requirements3-odoo16.txt https://raw.githubusercontent.com/odoo/odoo/16.0/requirements.txt
wget -O requirements3-odoomaster.txt https://raw.githubusercontent.com/odoo/odoo/master/requirements.txt
cat requirements3-*.txt | grep -v "sys_platform == 'win32'" | sed -r -e 's,^([A-Za-z0-9_\.-]+)(.*)$,\1,' | tr A-Z a-z | sort | uniq | grep -v suds-jurko | grep -v vatnumber > requirements3-latest.txt
