#! /bin/bash
cd ~
if [ -e scott-misc ]; then
    cd scott-misc
    git pull
    cd ..
else
    git clone https://github.com/sbconsulting/misc.git scott-misc
fi
cd scott-misc/xos
cp aliases.sh teardown.sh bringup.sh /opt/cord/build/platform-install/scripts/
source aliases.sh
echo "source /opt/cord/build/platform-install/scripts/aliases.sh" >> ~/.bashrc
