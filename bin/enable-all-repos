#!/bin/bash

#
# enable-all-repos.sh
#
# enable all the repositories in katello instance

function k {
  ~/.bin/katello "$@"
}

for PRODUCT in $(~/.bin/katello product list -g -d XX | awk -F XX '{print $2}')
do
  k repo list --include_disabled -g -d XX | awk -F XX '{print $1}' | xargs -n1 -I arg1 k repo enable --product $PRODUCT --id arg1
done