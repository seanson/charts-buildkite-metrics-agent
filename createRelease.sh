#!/bin/bash

GH_USERNAME="seanson"
REPO="charts-buildkite-metrics-agent"
DEPLOY_DIR=".deploy/"

echo "Buildking Helm package into .deploy"
helm3 package . --destination "${DEPLOY_DIR}"

echo "Publishing package to GitHub"
cr upload -o "${GH_USERNAME}" -r "${REPO}" -p "${DEPLOY_DIR}" --token "${GH_TOKEN}"

echo "Package published, you may now run the re-index from the $GH_USERNAME-charts repo"
