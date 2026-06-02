#!/bin/bash
# echo "Enter relative path to the initial local folder"
# read -r LOCAL_PATH="$1"
# echo "Enter S3 storage name"
# read -r STORAGE_NAME="$2"
# echo "Enter S3 bucket name"
# read -r BUCKET_NAME="$3"

# LOCAL_PATH="$1"
# STORAGE_NAME="$2"
# BUCKET_NAME="$3"
# mc rm --recursive --force $STORAGE_NAME/$BUCKET_NAME
# mc cp --recursive $LOCAL_PATH/ $STORAGE_NAME/$BUCKET_NAME

mc rm --recursive --force miniolocal/test-static
mc cp --recursive initial-static/ miniolocal/test-static
