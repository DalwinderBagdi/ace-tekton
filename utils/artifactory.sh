#!/bin/bash

echo "pushing to artifactory"

curl -u ${ARTIFACTORY_USER}:${ARTIFACTORY_PASSWORD} -T ./ace-simple-flow/${PROJECT}/gen/${PROJECT}.bar "http://159.8.178.163/artifactory/test/${PROJECT}.bar"

curl -u ${ARTIFACTORY_USER}:${ARTIFACTORY_PASSWORD} -T ./ace-simple-flow/${PROJECT}/gen/${PROJECT}.msgflow "http://159.8.178.163/artifactory/test/${PROJECT}.msgflow"


