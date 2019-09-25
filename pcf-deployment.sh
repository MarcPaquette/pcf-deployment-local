#!/bin/bash -exu
source environment/bosh_env.sh
source environment/bosh_login.sh

bosh -e $BOSH_ENVIRONMENT  upload-stemcell https://bosh.io/d/stemcells/bosh-warden-boshlite-ubuntu-xenial-go_agent?v=170.78

bosh -e $BOSH_ENVIRONMENT update-cloud-config bosh-lite/cloud-config.yml -n

bosh -e $BOSH_ENVIRONMENT  -d cf deploy ~/Downloads/pcf-deployment/pcf-deployment/pcf-deployment.yml \
  -o operations/bosh-lite.yml \
  -o operations/scale-to-one-az.yml \
  --vars-file operations/ssh_proxy_backend_tls.yml \
  -v system_domain=bosh-lite.com \
  --recreate \
  --fix \
  -n
