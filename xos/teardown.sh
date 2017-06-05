#! /bin/bash
set -e
cd /opt/cord/build/platform-install
ansible-playbook -i inventory/rcord --extra-vars @../genconfig/config.yml teardown-playbook.yml
source /opt/cord_profile/admin-openrc.sh
/opt/cord/build/platform-install/scripts/cleanup.sh
IMAGES=$(docker images | grep -i xosproject/xos | awk '{print $3 }')
if [ ! -z "$IMAGES" ]; then
    docker rmi -f $IMAGES
fi
IMAGES=$(docker images | grep -i synchro | awk '{print $3 }')
if [ ! -z "$IMAGES" ]; then
    docker rmi -f $IMAGES
fi
cd /opt/onos_cord
docker stop onoscord_xos-onos_1
docker rm onoscord_xos-onos_1
docker-compose up -d
