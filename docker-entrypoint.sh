#!/bin/bash

TIMESTAMP=`date --utc +%Y%m%d_%H%M%SZ`

PGPASSWORD="$DB_PASSWORD" pg_dump -u $DB_USERNAME -p $DB_PORT -d $DB_NAME -h $DB_HOST > $TIMESTAMP.dump
RESULT=$?
if [ ${RESULT} -ne 0 ]; then
    echo "Pg_dump failed, exiting..."
    exit 1
fi

aws s3 cp $TIMESTAMP.dump s3://$BUCKET_NAME/$BUCKET_PATH --region $REGION
RESULT=$?
if [ ${RESULT} -ne 0 ]; then
    echo "Copy to S3 failed, exiting..."
    exit 1
fi

rm -rf $TIMESTAMP.dump

