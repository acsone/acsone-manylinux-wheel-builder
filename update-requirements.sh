#!/bin/bash
wget -O requirements-py3o-renderserver.txt https://bitbucket.org/xcgd/py3oserver_docker/raw/default/sources/pip_reqs.txt
wget -O requirements-py3o-fusion.txt https://bitbucket.org/xcgd/py3o.fusion/raw/default/sources/pip_reqs.txt
wget -O requirements-odoo8.txt https://raw.githubusercontent.com/odoo/odoo/8.0/requirements.txt
wget -O requirements-odoo9.txt https://raw.githubusercontent.com/odoo/odoo/9.0/requirements.txt
wget -O requirements-odoo10.txt https://raw.githubusercontent.com/odoo/odoo/10.0/requirements.txt
cat requirements-*.txt | grep -v "sys_platform == 'win32'" | sed -r -e 's,^([A-Za-z0-9_-\.]+)(.*)$,\1,' | tr A-Z a-z | sort | uniq > requirements-latest.txt

wget -O requirements3-odoo11.txt https://raw.githubusercontent.com/odoo/odoo/11.0/requirements.txt
wget -O requirements3-odoomaster.txt https://raw.githubusercontent.com/odoo/odoo/master/requirements.txt
cat requirements3-*.txt | grep -v "sys_platform == 'win32'" | sed -r -e 's,^([A-Za-z0-9_-\.]+)(.*)$,\1,' | tr A-Z a-z | sort | uniq > requirements3-latest.txt
