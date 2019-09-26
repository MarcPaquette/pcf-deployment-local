source environment/bosh_env.sh
source environment/bosh_login.sh

bosh int $DEPLOYMENT_DIRECTORY/creds.yml --path /jumpbox_ssh/private_key > $DEPLOYMENT_DIRECTORY/jumpbox.key
chmod 600 $DEPLOYMENT_DIRECTORY/jumpbox.key
ssh jumpbox@192.168.50.6 -i $DEPLOYMENT_DIRECTORY/jumpbox.key

