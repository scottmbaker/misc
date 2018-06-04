#! /bin/bash

set -e
sudo docker pull xosproject/xos-base:master
sudo docker tag xosproject/xos-base:master xosproject/xos-base:candidate
