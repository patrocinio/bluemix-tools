#!/bin/bash
# Inspired by https://hub.jazz.net/project/communitysample/postgresql-nodejs/overview
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 application service connection"
  echo "Sample of connection: redis://x:[password]@aws-us-east-1-portal.16.dblayer.com:11132"
  exit 1
fi

APP_NAME=$1
SERVICE_NAME=$2
URI=$3

TEMP_FILE=/tmp/new1.json


#Create a JSON File
echo "{\"credentials\":\"$URI\"}" > $TEMP_FILE

# Update the service
echo "Updating the service"
echo "Running cf uups $SERVICE_NAME -p $TEMP_FILE"
cf uups $SERVICE_NAME -p $TEMP_FILE

echo "Restage the Applicatiion"
echo "Running cf restage $APP_NAME"
cf restage $APP_NAME

if [[ $? -ne 0 ]];
then
    echo Failed to bind $SERVICE_NAME to $APP_NAME
fi
