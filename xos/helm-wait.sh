#!/bin/bash
GUI_URL=`minikube service xos-gui --url`
echo "GUI URL is", $GUI_URL
~/cord/build/scripts/xos-wait-dynamicload.py $GUI_URL vsg-hw volt fabric vrouter
