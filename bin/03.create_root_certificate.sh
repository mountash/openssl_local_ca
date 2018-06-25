#!/bin/bash

CUR_DIR=$PWD

source variables.sh
source helpers.sh

cd $RF

if [ ! -f $ROOT_CERT_FILE ]; then
    info "Creating root certificate"
    openssl req -config $OPENSSL_CFG -key $ROOT_KEY_FILE -new -x509 -days 7300 -sha256 -extensions v3_ca -out $ROOT_CERT_FILE 
    chmod 444 $ROOT_CERT_FILE
else
    error "Root Certificate already exists in $ROOT_CERT_FILE"
    exit 1
fi

cd $CUR_DIR

