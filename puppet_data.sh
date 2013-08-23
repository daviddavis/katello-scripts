#!/bin/bash

#
# cv_data.sh
#
# load up the database with some content view data

function k {
  ~/.bin/katello "$@"
}

k environment create --org=ACME_Corporation --name=Dev --prior=Library
k environment create --org=ACME_Corporation --name=Staging --prior=Dev

k content definition create --org=ACME_Corporation --name=PuppetMods

k provider create --org=ACME_Corporation --name=PuppetLabs
k product create --org=ACME_Corporation --name=PForge --provider=PuppetLabs

k repo create --name=pforge --url="http://forge.puppetlabs.com" --product=PForge --content_type=puppet
k repo synchronize --org=ACME_Corporation --name=pforge --product_label=PForge

k content definition add_repo --org=ACME_Corporation --name=PuppetMods --repo=pforge --product=PForge
