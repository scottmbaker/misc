#! /bin/bash
cd ~
git clone https://github.com/sbconsulting/misc.git scott-misc
cd scott-misc/xos
cp teardown.sh bringup.sh /opt/cord/build/platform-install/scripts/
