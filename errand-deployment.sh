#!/bin/bash -exu
source environment/bosh_env.sh
source environment/bosh_login.sh

#TODO: Change this directory to be more user friendly
export PCF_DEPLOYMENT_DIRECTORY=~/Downloads/pcf-deployment/pcf-deployment


bosh -e $BOSH_ENVIRONMENT  -d deploy-autoscaling deploy $PCF_DEPLOYMENT_DIRECTORY/errands/deploy-autoscaling.yml \
  --vars-file operations/ssh_proxy_backend_tls.yml \
  --vars-store $DEPLOYMENT_DIRECTORY/deployment-vars.yml \
  -v system_domain=bosh-lite.com \
  --recreate \
  --fix \
  -n

#TODO: This doesn't work
bosh -e $BOSH_ENVIRONMENT  -d deploy-notifications deploy $PCF_DEPLOYMENT_DIRECTORY/errands/deploy-notifications.yml \
  --vars-file operations/ssh_proxy_backend_tls.yml \
  --vars-store $DEPLOYMENT_DIRECTORY/deployment-vars.yml \
  -v system_domain=bosh-lite.com \
  --recreate \
  --fix \
  -n

#TODO: This doesn't work
bosh -e $BOSH_ENVIRONMENT  -d deploy-notifications-ui deploy $PCF_DEPLOYMENT_DIRECTORY/errands/deploy-notifications-ui.yml \
  --vars-file operations/ssh_proxy_backend_tls.yml \
  --vars-store $DEPLOYMENT_DIRECTORY/deployment-vars.yml \
  -v system_domain=bosh-lite.com \
  --recreate \
  --fix \
  -n

bosh -e $BOSH_ENVIRONMENT  -d push-apps-manager deploy $PCF_DEPLOYMENT_DIRECTORY/errands/push-apps-manager.yml \
  --vars-file operations/ssh_proxy_backend_tls.yml \
  --vars-store $DEPLOYMENT_DIRECTORY/deployment-vars.yml \
  -v system_domain=bosh-lite.com \
  --recreate \
  --fix \
  -n

bosh -e $BOSH_ENVIRONMENT  -d push-usage-service deploy $PCF_DEPLOYMENT_DIRECTORY/errands/push-usage-service.yml \
  --vars-file operations/ssh_proxy_backend_tls.yml \
  --vars-store $DEPLOYMENT_DIRECTORY/deployment-vars.yml \
  -v system_domain=bosh-lite.com \
  --recreate \
  --fix \
  -n
