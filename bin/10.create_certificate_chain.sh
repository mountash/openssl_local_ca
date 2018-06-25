#!/bin/bash

CUR_DIR=$PWD

source variables.sh
source helpers.sh

cd $RF

if [ ! -f $ROOT_CERT_FILE ]; then
    error "No Root Certificate found in $ROOT_CERT_FILE"
    exit 1
fi

if [ ! -f $INT_CERT_FILE ]; then
    error "No Intermediate Certificate found in $INT_CERT_FILE"
    exit 1
fi

if [ -f $INT_ROOT_CERT_CHAIN ]; then
    error "Certificate chain already exists in $INT_ROOT_CERT_CHAIN"
    exit 1
else
    info "Creating certificate chain in $INT_ROOT_CERT_CHAIN"
    cat $INT_CERT_FILE $ROOT_CERT_FILE > $INT_ROOT_CERT_CHAIN
    chmod 444 $INT_ROOT_CERT_CHAIN
fi

cd $CUR_DIR

