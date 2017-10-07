#!/bin/bash
wget -O requirements-py3o-renderserver.txt https://bitbucket.org/xcgd/py3oserver_docker/raw/default/sources/pip_reqs.txt
wget -O requirements-py3o-fusion.txt https://bitbucket.org/xcgd/py3o.fusion/raw/default/sources/pip_reqs.txt
wget -O requirements-odoo8.txt https://raw.githubusercontent.com/odoo/odoo/8.0/requirements.txt
wget -O requirements-odoo9.txt https://raw.githubusercontent.com/odoo/odoo/9.0/requirements.txt
wget -O requirements-odoo10.txt https://raw.githubusercontent.com/odoo/odoo/10.0/requirements.txt
wget -O requirements-odoo11.txt https://raw.githubusercontent.com/odoo/odoo/11.0/requirements.txt
wget -O requirements-odoomaster.txt https://raw.githubusercontent.com/odoo/odoo/master/requirements.txt
cat requirements-*.txt | sed -e 's,==.*$,,' | sort | uniq > requirements-latest.txt
