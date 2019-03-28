#!/usr/bin/env bash

sudo apt-get update
sudo apt-get -y install apt-transport-https build-essential curl git python-dev python-pip software-properties-common sshpass libffi-dev qemu-kvm libvirt-bin libvirt-dev nfs-kernel-server socat

pip install gitpython graphviz docker "Jinja2>=2.9" virtualenv ansible ansible-modules-hashivault netaddr PyOpenSSL flake8 yamllint tox

ping -c3 -w1 gerrit.opencord.org

REPO_SHA256SUM="394d93ac7261d59db58afa49bb5f88386fea8518792491ee3db8baab49c3ecda"
curl -o /tmp/repo 'https://gerrit.opencord.org/gitweb?p=repo.git;a=blob_plain;f=repo;hb=refs/heads/stable'
echo "$REPO_SHA256SUM  /tmp/repo" | sha256sum -c -
sudo cp /tmp/repo /usr/local/bin/repo
sudo chmod a+x /usr/local/bin/repo

git config --global user.name 'Test User'
git config --global user.email 'test@null.com'
git config --global color.ui false

cd ~
mkdir -p cord
cd cord
repo init -u https://gerrit.opencord.org/manifest -b master
repo sync

cd ~/cord/automation-tools
./openstack-helm/cloudlab-disk-setup.sh

cd ~/cord/automation-tools/seba-in-a-box
make /tmp/milestones/logging # this installs docker/k8s
