#!/bin/bash

for PRODUCT in $(~/.bin/katello product list -g -d XX | awk -F XX '{print $2}')
do
  ~/.bin/katello repo list --include_disabled -g -d XX | awk -F XX '{print $1}' | xargs -n1 -I arg1 katello -u admin -p admin repo enable --product $PRODUCT --id arg1
done