#!/bin/bash

CUR_DIR=$PWD

source variables.sh
source helpers.sh

cd $RF

if [ ! -f $ROOT_CERT_FILE ]; then
    error "No Root Certificate found in $ROOT_CERT_FILE"
    exit 1
else
    openssl x509 -noout -text -in $ROOT_CERT_FILE
fi

cd $CUR_DIR

