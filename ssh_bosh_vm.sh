source environment/bosh_env.sh
source environment/bosh_login.sh

bosh int $DEPLOYMENT_DIRECTORY/creds.yml --path /jumpbox_ssh/private_key > jumpbox.key
chmod 600 jumpbox.key
ssh jumpbox@192.168.50.6 -i jumpbox.key

