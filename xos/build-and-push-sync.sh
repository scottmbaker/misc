#! /bin/bash
SYNCS=$@
set -e
#/opt/smbaker/rebuild-local.sh xos-synchronizer-base
/opt/smbaker/rebuild-local.sh $SYNCS
/opt/smbaker/push-candidates.sh $SYNCS
