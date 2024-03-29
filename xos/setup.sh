#! /bin/bash
pushd ~
if [ -e scott-misc ]; then
    cd scott-misc
    git pull
    cd ..
else
    git clone https://github.com/sbconsulting/misc.git scott-misc
fi
cd scott-misc/xos
sudo mkdir -p /opt/smbaker
sudo chown smbaker /opt/smbaker
cp *.sh *.py /opt/smbaker/
source aliases.sh
echo "source /opt/smbaker/aliases.sh" >> ~/.bashrc
popd