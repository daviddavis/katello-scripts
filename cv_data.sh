#!/bin/bash

#
# cv_data.sh
#
# load up the database with some content view data

source "$(dirname $0)/setup.sh"

k environment create --name=Dev --prior=Library
k environment create --name=Staging --prior=Dev

k content definition create --name=NoSQL
k content definition create --name=RHEL7

k provider create --name=Adobe
k provider create --name=IBM
k product create --provider=Adobe --name=Zooshop
k product create --provider=IBM --name=WatsonDB

k repo create --product_label=Zooshop --url="http://mmccune.fedorapeople.org/discovery/zoo/" --name=zoo
k repo create --product_label=WatsonDB --url="http://mmccune.fedorapeople.org/discovery/acme/" --name=acme
k repo create --product_label=Zooshop --url="http://mmccune.fedorapeople.org/discovery/zoo_ks2/" --name=zoo_ks2
k repo create --product_label=Zooshop --url="http://inecas.fedorapeople.org/fakerepos/zoo2/" --name=zoo2
k repo create --product_label=WatsonDB --url="http://inecas.fedorapeople.org/fakerepos/ks/" --name=ks

k repo synchronize --name=zoo --product_label=Zooshop
k repo synchronize --name=acme --product_label=WatsonDB
k repo synchronize --name=zoo_ks2 --product_label=Zooshop
k repo synchronize --name=zoo2 --product_label=Zooshop
k repo synchronize --name=ks --product_label=WatsonDB

k content definition add_product --name=NoSQL --product=WatsonDB
k content definition add_repo --name=RHEL7 --repo=zoo --product=Zooshop
k content definition add_repo --name=RHEL7 --repo=zoo_ks2 --product=Zooshop

k content definition publish --view_name=NoSQL1 --label=NoSQL
k content definition publish --view_name=NoSQL2 --name=NoSQL
k content definition publish --view_name=RHEL7-1 --label=RHEL7
k content definition publish --view_name=RHEL7-2 --name=RHEL7

k content view promote --name=NoSQL1 --env=Dev
k content view promote --name=NoSQL2 --env=Dev
k content view promote --name=RHEL7-1 --env=Dev
k content view promote --name=RHEL7-1 --env=Staging
k content view promote --name=RHEL7-2 --env=Dev
k content view promote --name=NoSQL2 --env=Staging

k content view refresh --label=NoSQL2
k content view promote --name=NoSQL2 --env=Dev
k content view refresh --label=NoSQL2
k content view refresh --label=RHEL7-2
