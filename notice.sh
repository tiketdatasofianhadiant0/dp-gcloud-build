#!/bin/sh
if [ "$(shuf -i 1-20 -n 1)" -eq 1 ]; then
  echo '
                   ***** NOTICE *****

Official `cloud-sdk` images, including multiple tagged versions across multiple
platforms, can be found at
https://github.com/GoogleCloudPlatform/cloud-sdk-docker.

Suggested alternative images include:

    gcr.io/google.com/cloudsdktool/cloud-sdk
    gcr.io/google.com/cloudsdktool/cloud-sdk:alpine
    gcr.io/google.com/cloudsdktool/cloud-sdk:debian_component_based
    gcr.io/google.com/cloudsdktool/cloud-sdk:slim

Please note that the `gcloud` entrypoint must be specified when using these
images.

                ***** END OF NOTICE *****
'
fi

MAX_RETRIES=11
DELAY_SECONDS=300
retries=0

while [ $retries -lt $MAX_RETRIES ]; do
  if /builder/google-cloud-sdk/bin/gcloud "$@"; then
    # Command succeeded, exit the loop
    break
  else
    # Command failed, increment retry count and wait before retrying
    retries=$((retries + 1))
    echo "Command failed, retrying in $DELAY_SECONDS seconds (attempt $retries of $MAX_RETRIES)..."
    sleep $DELAY_SECONDS
  fi
done

if [ $retries -eq $MAX_RETRIES ]; then
  echo "Maximum number of retries reached. Exiting..."
  exit 1
fi
