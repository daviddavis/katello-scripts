#!/bin/bash

function k {
  ~/.bin/katello "$@"
}

k environment create --org=ACME_Corporation --name=Dev --prior=Library
k environment create --org=ACME_Corporation --name=Staging --prior=Dev

k content definition create --org=ACME_Corporation --name=NoSQL
k content definition create --org=ACME_Corporation --name=RHEL7

k provider create --org=ACME_Corporation --name=Adobe
k provider create --org=ACME_Corporation --name=IBM
k product create --org=ACME_Corporation --provider=Adobe --name=Zooshop
k product create --org=ACME_Corporation --provider=IBM --name=WatsonDB

k repo create --org=ACME_Corporation --product_label=Zooshop --url="http://mmccune.fedorapeople.org/discovery/zoo/" --name=zoo
k repo create --org=ACME_Corporation --product_label=WatsonDB --url="http://mmccune.fedorapeople.org/discovery/acme/" --name=acme
k repo create --org=ACME_Corporation --product_label=Zooshop --url="http://mmccune.fedorapeople.org/discovery/zoo_ks2/" --name=zoo_ks2
k repo create --org=ACME_Corporation --product_label=Zooshop --url="http://inecas.fedorapeople.org/fakerepos/zoo2/" --name=zoo2
k repo create --org=ACME_Corporation --product_label=WatsonDB --url="http://inecas.fedorapeople.org/fakerepos/ks/" --name=ks

k repo synchronize --org=ACME_Corporation --name=zoo --product_label=Zooshop
k repo synchronize --org=ACME_Corporation --name=acme --product_label=WatsonDB
k repo synchronize --org=ACME_Corporation --name=zoo_ks2 --product_label=Zooshop
k repo synchronize --org=ACME_Corporation --name=zoo2 --product_label=Zooshop
k repo synchronize --org=ACME_Corporation --name=ks --product_label=WatsonDB

k content definition add_product --org=ACME_Corporation --name=NoSQL --product=WatsonDB
k content definition add_repo --org=ACME_Corporation --name=RHEL7 --repo=zoo --product=Zooshop
k content definition add_repo --org=ACME_Corporation --name=RHEL7 --repo=zoo_ks2 --product=Zooshop

k content definition publish --org=ACME_Corporation --view_name=NoSQL1 --label=NoSQL
k content definition publish --org=ACME_Corporation --view_name=NoSQL2 --name=NoSQL
k content definition publish --org=ACME_Corporation --view_name=RHEL7-1 --label=RHEL7
k content definition publish --org=ACME_Corporation --view_name=RHEL7-2 --name=RHEL7

k content view promote --org=ACME_Corporation --name=NoSQL1 --env=Dev
k content view promote --org=ACME_Corporation --name=NoSQL2 --env=Dev
k content view promote --org=ACME_Corporation --name=RHEL7-1 --env=Dev
k content view promote --org=ACME_Corporation --name=RHEL7-1 --env=Staging
k content view promote --org=ACME_Corporation --name=RHEL7-2 --env=Dev
k content view promote --org=ACME_Corporation --name=NoSQL2 --env=Staging

k content view refresh --org=ACME_Corporation --label=NoSQL2
k content view promote --org=ACME_Corporation --name=NoSQL2 --env=Dev
k content view refresh --org=ACME_Corporation --label=NoSQL2
k content view refresh --org=ACME_Corporation --label=RHEL7-2
