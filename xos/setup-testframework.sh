#! /bin/bash
pushd ~/cord/orchestration/xos
sudo pip install plyxproto inflect astunparse pykwalify multistructlog nose2 mock networkx==1.11 requests-mock netaddr jinja2 confluent-kafka
cd ~/cord/orchestration/xos
cd lib/xos-util
sudo python ./setup.py install
cd ../xos-genx
sudo python ./setup.py install
cd ../xos-config
sudo python ./setup.py install
cd ../..
nose2 --verbose
popd
