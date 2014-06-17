#!/bin/bash

#
# base.sh
#
# setup common items for katello-scripts
#

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

KATELLO_CLI_PATH=${KATELLO_CLI_PATH:-"~/Projects/hammer-cli-katello/"}
KATELLO_ORG=${KATELLO_ORG:-ACME_Corporation}
ORG_PARAM="--organization=$KATELLO_ORG"

function h {
  cd $KATELLO_CLI_PATH && bundle exec hammer $@
}

function k {
  cd $KATELLO_CLI_PATH && bundle exec hammer $@ $ORG_PARAM
}

