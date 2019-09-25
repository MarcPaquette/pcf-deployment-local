#!/bin/bash -exu 

#set up env for all environments

#Set up bosh env
source ./environment/bosh_env.sh

#log into bosh env
source ./environment/bosh_login.sh

#Add this:
# $ sudo route add -net 10.244.0.0/16     192.168.50.6 # Mac OS X
# $ sudo ip route add   10.244.0.0/16 via 192.168.50.6 # Linux (using iproute2 suite)
# $ sudo route add -net 10.244.0.0/16 gw  192.168.50.6 # Linux (using DEPRECATED route command)
# $ route add           10.244.0.0/16     192.168.50.6 # Windows


#log into cloud foundry via cli
source ./environment/cf_env.sh
