#!/bin/bash

CUR_DIR=$PWD

source variables.sh
source helpers.sh

cd $RF

if [ ! -f $INT_CERT_FILE ]; then
    info "Signing intermediate certificate request"
    openssl ca -config $OPENSSL_CFG -extensions v3_intermediate_ca -days 3650 -notext -md sha256 -in $INT_CERT_REQ_FILE -out $INT_CERT_FILE 
    chmod 444 $INT_CERT_FILE
    info "index.txt should now contain a line that refers to the intermediate certificate"
    cat $RF/index.txt
else
    error "Intermediate Certificate already exists in $INT_CERT_FILE"
    exit 1
fi

cd $CUR_DIR

