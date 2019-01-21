BASEURL=https://mami.cloudlab.zhaw.ch/mami/pto

CAMPAIGN=$1
BASEFILE=$2

if [ ! -f ${BASEFILE} ]; then
   echo data file ${BASEFILE} missing
   exit 1
fi

METAFILE=${BASEFILE}.meta.json
if [ ! -f ${METAFILE} ]; then
   echo metadata file ${METAFILE} missing
   exit 1
fi

echo Compressing ${BASEFILE}...
bzip2 $BASEFILE
BZFILE=${BASEFILE}.bz2
if [ ! -f ${METAFILE} ]; then
   echo failed to compress: ${BZFILE} missing
   exit 1
fi

echo "uploading metadata..."

curl -X PUT \
    -H "Authorization: APIKEY `cat token`" \
    -H "Content-type: application/json" \
    ${BASEURL}/raw/${CAMPAIGN}/${BZFILE} \
    --data-binary @${METAFILE} | jq

rv=$?
if [ $rv -ne 0 ]; then
    echo "failed to upload metadata, aborting"
    exit $rv
fi

echo "uploading data..."

curl -X PUT \
    -H "Authorization: APIKEY `cat token`" \
    -H "Content-type: application/bzip2" \
    ${BASEURL}/raw/${CAMPAIGN}/${BZFILE}/data \
    --data-binary @${BZFILE} | jq

rv=$?
if [ $rv -ne 0 ]; then
    echo "failed to upload data, aborting"
    exit $rv
fi