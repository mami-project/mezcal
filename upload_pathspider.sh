INSTANCE=`cat instance`
PLUGIN=`cat plugin`
VANTAGE=`cat vantage`
CAMPAIGN=`cat campaign`
TOKEN=`cat pto-apikey`

echo {\"time\": \"`date -Iseconds`\", \"status\": \"uploading to pto\"} >> /var/www/html/status.ndjson
pspdr metadata -t pathspider-v2-ndjson-bz2 --extra vantage:${VANTAGE} ${INSTANCE}-${PLUGIN}.ndjson.bz2
pspdr upload \
    --metadata results-ecn.ndjson.bz2.json \
    --campaign ${CAMPAIGN} --token ${TOKEN} \
    --url https://v3.pto.mami-project.eu

echo {\"time\": \"`date -Iseconds`\", \"status\": \"run_pathspider complete\"} >> /var/www/html/status.ndjson
touch "run_pathspider_complete"