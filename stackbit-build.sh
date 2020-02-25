#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5e5540ab63582e001feef490/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5e5540ab63582e001feef490 
fi
curl -s -X POST https://api.stackbit.com/project/5e5540ab63582e001feef490/webhook/build/ssgbuild > /dev/null
make prepare && hugo --source demo --baseURL "/"
curl -s -X POST https://api.stackbit.com/project/5e5540ab63582e001feef490/webhook/build/publish > /dev/null
