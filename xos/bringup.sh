#! /bin/bash
set -e
cd /opt/cord/build/platform-install
ansible-playbook -i inventory/head-localhost --extra-vars @/opt/cord/build/genconfig/config.yml launch-xos-playbook.yml
ansible-playbook -i /etc/maas/ansible/pod-inventory --extra-vars=@/opt/cord/build/genconfig/config.yml compute-node-refresh-playbook.yml
ansible-playbook -i inventory/rcord --extra-vars @../genconfig/config.yml pod-test-playbook.yml
