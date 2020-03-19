export NOP=`kubectl get pods | grep -i nem-ondemand-proxy | grep -i running | cut -f1 -d " "`
export OLT=`kubectl get pods -n voltha | grep -i adapter-open-olt | grep -i running | cut -f1 -d " "`
export ONU=`kubectl get pods -n voltha | grep -i adapter-open-onu | grep -i running | cut -f1 -d " "`
export CORE=`kubectl get pods -n voltha | grep -i voltha-rw-core | grep -i running | cut -f1 -d " "`
export BB=`kubectl get pods -n voltha | grep -i bbsim | grep -i running | cut -f1 -d " "`
