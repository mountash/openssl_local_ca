#!/bin/bash

CUR_DIR=$PWD

source variables.sh
source helpers.sh

cd $RF

if [ ! -f $INT_CERT_REQ_FILE ]; then
    info "Creating intermediate certificate request"
    openssl req -config $INT_OPENSSL_CFG -new -sha256 -key $INT_KEY_FILE -out $INT_CERT_REQ_FILE 
    chmod 444 $ROOT_CERT_FILE
else
    error "Intermediate Certificate Request already exists in $INT_CERT_REQ_FILE"
    exit 1
fi

cd $CUR_DIR

