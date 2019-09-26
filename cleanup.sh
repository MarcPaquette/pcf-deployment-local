#!/bin/bash -exu
source environment/bosh_env.sh
source environment/bosh_login.sh
#delete deployment
bosh -e $BOSH_ENVIRONMENT  -d cf delete-deployment
#delete working directories
#This is dumb to do
rm -rf $BOSH_LITE_DIRECTORY
rm -rf $DEPLOYMENT_DIRECTORY
#delete vms
#delete bosh cpi info
