#!/bin/bash -exu
## Install and create Bosh lite under vbox then deploy cf-deployment on top of it
#requires vbox
#requires bosh2 cli
#requires cf cli


#Set environment variables for installation directories
source ./environment/bosh_env.sh

##Create Bosh-lite
#source for these steps: http://bosh.io/docs/bosh-lite.html
#clone bosh-deployment
if [ -d "$BOSH_LITE_DIRECTORY" ]
then
  (cd $BOSH_LITE_DIRECTORY; git pull) 
else
  git clone https://github.com/cloudfoundry/bosh-deployment $BOSH_LITE_DIRECTORY
fi

#set up your workspace
if [ -d "$DEPLOYMENT_DIRECTORY" ]
then
  echo "deployment directory exists"
  awk '!/current_manifest_sha/' $DEPLOYMENT_DIRECTORY/state.json > temp && mv temp $DEPLOYMENT_DIRECTORY/state.json #using awk for portablity
else
  mkdir -p $DEPLOYMENT_DIRECTORY
fi

#edit deployment manifest
#Raise the RAM for more wiggle room
# awk '{ gsub("memory: 4096","memory: 6144"); print $0 }' $BOSH_LITE_DIRECTORY/virtualbox/cpi.yml > temp.cpi && mv temp.cpi $BOSH_LITE_DIRECTORY/virtualbox/cpi.yml 
#TODO: raise disk
#TODO: Raise CPUs

#create bosh director
bosh create-env $BOSH_LITE_DIRECTORY/bosh.yml \
  --state $DEPLOYMENT_DIRECTORY/state.json \
  -o $BOSH_LITE_DIRECTORY/virtualbox/cpi.yml \
  -o $BOSH_LITE_DIRECTORY/virtualbox/outbound-network.yml \
  -o $BOSH_LITE_DIRECTORY/bosh-lite.yml \
  -o $BOSH_LITE_DIRECTORY/bosh-lite-runc.yml \
  -o $BOSH_LITE_DIRECTORY/uaa.yml \
  -o $BOSH_LITE_DIRECTORY/credhub.yml \
  -o $BOSH_LITE_DIRECTORY/jumpbox-user.yml \
  -o bosh-lite/disk_memory.yml \
  --vars-store $DEPLOYMENT_DIRECTORY/creds.yml \
  -v director_name=bosh-lite \
  -v internal_ip=192.168.50.6 \
  -v internal_gw=192.168.50.1 \
  -v internal_cidr=192.168.50.0/24 \
  -v outbound_network_name=NatNetwork

#Set bosh log-in info
source ./environment/bosh_login.sh

#confirm works
bosh -e pcf env

#Enable BOSH DNS
bosh -e pcf  update-runtime-config $BOSH_LITE_DIRECTORY/runtime-configs/dns.yml --vars-store $DEPLOYMENT_DIRECTORY/bosh-dns-certs.yml -n



