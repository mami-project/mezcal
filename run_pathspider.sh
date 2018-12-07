INSTANCE=`cat instance`
PLUGIN=`cat plugin`

echo {\"time\": \"`date -Iseconds`\", \"status\": \"running pspdr measure ${PLUGIN}\"} >> /var/www/html/status.ndjson
pspdr measure $PLUGIN < targets-filtered.ndjson | bzip2 > ${INSTANCE}-${PLUGIN}.ndjson.bz2

echo {\"time\": \"`date -Iseconds`\", \"status\": \"measurement complete\"} >> /var/www/html/status.ndjson

bash ./upload_pathspider.sh
