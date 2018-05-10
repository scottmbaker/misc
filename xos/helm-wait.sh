#!/bin/bash
GUI_URL=`minikube service xos-gui --url`
echo "GUI URL is", $GUI_URL
python ~/cord/build/scripts/xos-wait-dynamicload.py 300 $GUI_URL vsg-hw volt fabric vrouter
