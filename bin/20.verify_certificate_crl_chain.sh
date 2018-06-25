#!/bin/bash

CUR_DIR=$PWD

source variables.sh
source helpers.sh

cd $RF

echo "Enter path to certificate file (ex.: /opt/ca/cert/example.cert.pem), followed by [ENTER]:"
read fileName

if [ -z "$fileName" ]; then
    error "File path cannot be empty"
    exit 1
fi

if [ ! -f $fileName ]; then
    error "Cannot find certificate file $fileName"
    exit 1
fi

info "Verifying Certificate"

openssl verify -crl_check -CAfile $INT_CRL_CHAIN $fileName

cd $CUR_DIR
