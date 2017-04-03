wget -O /tmp/r1 https://bitbucket.org/xcgd/py3oserver_docker/raw/default/sources/pip_reqs.txt
wget -O /tmp/r2 https://bitbucket.org/xcgd/py3o.fusion/raw/default/sources/pip_reqs.txt
cat /tmp/r1 /tmp/r2 | sort | uniq > requirements-py3o.txt
