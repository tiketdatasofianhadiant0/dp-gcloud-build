#!/bin/sh

docker build -t asia-southeast1-docker.pkg.dev/prod-datarangers/gcf-artifacts/dp_gcloud_slim:1.0.0-dp-custom -f Dockerfile.slim . && \
gcloud auth configure-docker && \
docker push asia-southeast1-docker.pkg.dev/prod-datarangers/gcf-artifacts/dp_gcloud_slim:1.0.0-dp-custom && \
docker rmi asia-southeast1-docker.pkg.dev/prod-datarangers/gcf-artifacts/dp_gcloud_slim:1.0.0-dp-custom