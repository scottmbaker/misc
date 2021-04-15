#!/bin/bash

set -e

if [ -z "$GERRITUSER" ]; then
    echo "set GERRITUSER"
    exit
fi

if [ -z "$GERRITPW" ]; then
    echo "set GERRITPW"
    exit
fi

sudo apt-get install -y git ethtool

sudo apt-get update && sudo apt-get install -y python-pip
#pip install --upgrade --user pip
sudo python -m pip install --upgrade pip==19.3.1
sudo pip install zipp

rm -rf aether-in-a-box
git clone https://${GERRITUSER}:${GERRITPW}@gerrit.opencord.org/a/aether-in-a-box
cd aether-in-a-box
sed -i 's/\xC2\xA0/ /g' Makefile
make /tmp/build/milestones/k8s-ready /tmp/build/milestones/helm-ready

mkdir -p $HOME/cord
cd $HOME/cord
git clone https://${GERRITUSER}:${GERRITPW}@gerrit.opencord.org/a/aether-helm-charts
cd $HOME/cord/aether-helm-charts/omec
helm dep update omec-control-plane

cd $HOME/cord
git clone https://${GERRITUSER}:${GERRITPW}@gerrit.opencord.org/a/helm-charts
cd helm-charts

cd $HOME
git clone https://github.com/sbconsulting/misc
sudo scp misc/aether-scripts/* /usr/bin/

cd $HOME
git clone https://github.com/sbconsulting/q3demo
