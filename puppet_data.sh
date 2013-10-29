#!/bin/bash

#
# puppet_data.sh
#
# load up the database with some puppet data

source "$(dirname $0)/setup.sh"

k environment create --name=Dev --prior=Library
k environment create --name=Staging --prior=Dev

k provider create --name=PuppetLabs
k product create --name=PForge --provider=PuppetLabs

k repo create --name=pforge --url="http://forge.puppetlabs.com" --product=PForge --content_type=puppet
k repo create --name=p --product=PForge --content_type=puppet

if [ ! -z $1]
then
  k repo synchronize --name=pforge --product_label=PForge
  k content definition create --name=PuppetMods
  k content definition add_repo --name=PuppetMods --repo=pforge --product=PForge
fi
