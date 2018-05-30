ONOS_ADDR=`kubectl get services | grep -i onos-cord-ssh | awk '{print $3}'`
ssh karaf@$ONOS_ADDR -p 8101
