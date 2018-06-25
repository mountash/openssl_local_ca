#!/bin/bash

CUR_DIR=$PWD

source variables.sh
source helpers.sh

cd $RF

if [ ! -f $INT_KEY_FILE ]; then
    info "Creating intermediate key"
    openssl genrsa -aes256 -out $INT_KEY_FILE 4096
    chmod 400 $INT_KEY_FILE
else
    error "Intermediate Key already exists in $INT_KEY_FILE"
    exit 1
fi

cd $CUR_DIR

