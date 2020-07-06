#!/bin/bash

printf "\n
----------------------------------------------------------------------------------------------------------------------------------------
\n 1. Creating snapshot \n
----------------------------------------------------------------------------------------------------------------------------------------\n"
printf "\n ./snapshot.json contents:\n"
echo '{ "name": "2.0", "application": "ace-custom", "description": "from tekton pipeline", "versions": [ {"ace-custom-image": "latest"} ]}' | tee ./snapshot.json

printf "\n"

curl -k -u "$UCD_USER":"$UCD_PASSWORD" "$UCD_URL:$UCD_PORT/cli/snapshot/createSnapshot" -X PUT --data @snapshot.json

printf "\n \n \n
----------------------------------------------------------------------------------------------------------------------------------------
\n 2. Creating json file with application json \n
----------------------------------------------------------------------------------------------------------------------------------------\n"
echo '{"application": "ace-custom", "applicationProcess": "deploy", "environment": "DEV", "onlyChanged": "false", "snapshot":"2.0" }' | tee ./deployment.json

printf "\n \n
----------------------------------------------------------------------------------------------------------------------------------------
\n 3. Requesting deployment from snapshot \n
----------------------------------------------------------------------------------------------------------------------------------------\n"
printf "Output from 'curl -k -u %s:%s %s:%s/cli/applicationProcessRequest/request -X PUT -d @deployment.json': ", "$UCD_USER" "$UCD_PASSWORD" "$UCD_URL" "$UCD_PORT"

REQUEST=$(
  curl -k -u "$UCD_USER":"$UCD_PASSWORD"
  "$UCD_URL:$UCD_PORT/cli/applicationProcessRequest/request" -X PUT -d @deployment.json
)

REQUEST_ID="${REQUEST:14:36}"

echo "Waiting for request to complete"
