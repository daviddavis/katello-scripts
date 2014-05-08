#!/bin/bash

#
# rh_data.sh
#
# load up the database with some red hat data
#

source "$(dirname $0)/base.sh"

k environment create --name Dev --prior Library
k environment create --name Staging --prior Dev

curl -o /tmp/rh-data-manifest.zip -X GET http://file.rdu.redhat.com/~mmccune/manifest-oct1-ks.zip
k provider import_manifest --name "Red Hat" --file /tmp/rh-data-manifest.zip

k product repository_set_enable --name "Red Hat Enterprise Linux Server" --set_name "Red Hat Enterprise Linux 6 Server (RPMs)"
#k product repository_set_enable --name "Red Hat Enterprise Linux Server" --set_name "Red Hat Enterprise Linux 6 Server (ISOs)"
#k product repository_set_enable --name "Red Hat Enterprise Linux Server" --set_name "Red Hat Enterprise Linux 6 Server (RPMs)"
#k product repository_set_enable --name "Red Hat Enterprise Linux Server" --set_name "Red Hat Enterprise Linux 6 Server - Optional (RPMs)"
#k product repository_set_enable --name "Red Hat Enterprise Linux Server" --set_name "Red Hat Enterprise Linux 6 Server - Supplementary (ISOs)"
#k product repository_set_enable --name "Red Hat Enterprise Linux Server" --set_name "Red Hat Enterprise Linux 6 Server - Supplementary (RPMs)"

k repo enable --product "Red Hat Enterprise Linux Server" --name "Red Hat Enterprise Linux 6 Server RPMs x86_64 6Server"

if [ -n $1 ]
then
  k provider synchronize --name "Red Hat"
fi
