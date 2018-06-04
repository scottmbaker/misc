#!/bin/bash

set -x

pushd ~

sudo apt-get update && sudo apt-get install -y python-git

curl -o /tmp/repo 'https://gerrit.opencord.org/gitweb?p=repo.git;a=blob_plain;f=repo;hb=refs/heads/stable'
sudo mv /tmp/repo /usr/local/bin/repo
sudo chmod a+x /usr/local/bin/repo
mkdir cord
cd cord
git config --global user.name 'Test User'
git config --global user.email 'test@null.com'
git config --global color.ui false
repo init -u https://gerrit.opencord.org/manifest
repo sync

popd
