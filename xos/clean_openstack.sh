#! /bin/bash

# Copyright 2017-present Open Networking Foundation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

export OS_CLOUD=openstack_helm

function cleanup_network {
  NETWORK=$1
  SUBNETS=`openstack network show $NETWORK | grep -i subnets | awk '{print $4}'`
  if [[ $SUBNETS != "" ]]; then
      PORTS=`openstack port list | grep -i $SUBNETS | awk '{print $2}'`
      for PORT in $PORTS; do
          echo "Deleting port $PORT"
          openstack port delete $PORT
      done
  fi
  openstack network delete $NETWORK
}

echo "Deleting VMs"
# Delete all VMs
VMS=$( openstack server list --all-projects|awk '{print $2}' )
for VM in $VMS
do
    openstack server delete $VM
done

echo "Waiting 5 seconds..."
sleep 5

echo "Deleting networks"
NETS=$( openstack network list|awk '{print $2}'|grep '^[0-9a-fA-F]' )
for NET in $NETS
do
    cleanup_network $NET
done
