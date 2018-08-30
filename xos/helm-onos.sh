ONOS_ADDR=`kubectl get services | grep -i onos-ssh | awk '{print $3}'`
ssh karaf@$ONOS_ADDR -p 8101
