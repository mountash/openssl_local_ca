#!/bin/bash

CUR_DIR=$PWD

source variables.sh
source helpers.sh

cd $RF

if [ ! -f $ROOT_KEY_FILE ]; then
    info "Creating root key"
    openssl genrsa -aes256 -out $ROOT_KEY_FILE 4096
    chmod 400 $ROOT_KEY_FILE
else
    error "Root Key already exists in $ROOT_KEY_FILE"
    exit 1
fi

cd $CUR_DIR

