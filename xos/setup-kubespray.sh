#!/bin/bash
set -e
git clone https://github.com/zdw/cloudlab_bootstrap
cd cloudlab_bootstrap/ks_install_tester
./test_bootstrap.sh
vagrant up
vagrant ssh-config >> ~/.ssh/config
vagrant ssh-config | sed -e 's/Host k8s-0/Host 10.90.0.10/g' >> ~/.ssh/config
cd ~/cord/automation-tools/kubespray-installer
REMOTE_SSH_USER="vagrant" ./setup.sh -i test
