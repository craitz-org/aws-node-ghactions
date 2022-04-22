#!/bin/bash

set -e

function_name="aws-node-ghactions"

result=$(sls deploy)
echo "${result}"

latest_version=$(aws lambda list-versions-by-function --function-name ${function_name} | grep "FunctionArn" | tail -1 | cut -d':' -f 9 | cut -d'"' -f 1)
echo "Latest version: ${latest_version}"

result=$(aws lambda update-alias --function-name ${function_name} --name $1 --function-version ${latest_version})
echo "${result}"
