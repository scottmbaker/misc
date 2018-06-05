#! /bin/bash

set -e
sudo docker pull xosproject/xos-base:master
sudo docker tag xosproject/xos-base:master xosproject/xos-base:candidate
sudo docker pull xosproject/xos-tosca:master
sudo docker tag xosproject/xos-tosca:master xosproject/xos-tosca:candidate
sudo docker pull xosproject/chameleon:master
sudo docker tag xosproject/chameleon:master xosproject/chameleon:candidate
sudo docker pull xosproject/xos-gui:master
sudo docker tag xosproject/xos-gui:master xosproject/xos-gui:candidate
sudo docker pull xosproject/xos-ws:master
sudo docker tag xosproject/xos-ws:master xosproject/xos-ws:candidate
