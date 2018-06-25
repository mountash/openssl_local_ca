#!/bin/bash

CUR_DIR=$PWD

source variables.sh
source helpers.sh

cd $RF

if [ ! -f $INT_CERT_FILE ]; then
    error "No Intermediate Certificate found in $INT_CERT_FILE"
    exit 1
else
    openssl x509 -noout -text -in $INT_CERT_FILE
    info "Verifying intermediate certificate against the root certificate"
    openssl verify -CAfile $ROOT_CERT_FILE $INT_CERT_FILE
fi

cd $CUR_DIR

