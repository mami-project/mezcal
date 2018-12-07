cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1 > instance
INSTANCE=`cat instance`

DROPLET_REGION=`cat region`

doctl compute droplet create ${INSTANCE}\
   --size s-2vcpu-2gb --image debian-9-x64 --region ${DROPLET_REGION} \
   --enable-ipv6 --ssh-keys ${DOCTL_SSH_KEY_FINGERPRINT} 

sleep 30

DROPLET_IP4=`doctl compute droplet list ${INSTANCE} --format PublicIPv4 | tail -1`
echo ${INSTANXCE} in ${DROPLET_REGION} is at ${DROPLET_IP4}

echo digitalocean-${DROPLET_REGION} > vantage
touch pto-apikey
touch targets.ndjson 

scp -oStrictHostKeyChecking=accept-new \
    instance_bootstrap.sh start.sh \
    run_hellfire.sh run_pathspider.sh \
    instance plugin campaign vantage pto-apikey targets.ndjson \
    root@${DROPLET_IP4}:.

ssh root@${DROPLET_IP4} -- bash -x ./instance_bootstrap.sh
ssh root@${DROPLET_IP4} -- bash -x ./start.sh