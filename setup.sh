#!/bin/bash

#
# setup.sh
#
# setup common items for katello-scripts
#

KATELLO_CLI_PATH=${KATELLO_CLI_PATH:-"/usr/bin/katello"}
KATELLO_USER=${KATELLO_USER:-admin}
KATELLO_PASS=${KATELLO_PASS:-admin}
KATELLO_ORG=${KATELLO_ORG:-ACME_Corporation}

function k {
  ${KATELLO_CLI_PATH} -u $KATELLO_USER -p $KATELLO_PASS "$@"
}

k client remember --option org --value $KATELLO_ORG

