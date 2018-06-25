#!/bin/bash

CUR_DIR=$PWD

source variables.sh
source helpers.sh

cd $RF

echo "Enter the server url (ex.: www.example.com), followed by [ENTER]:"
read serverUrl

if [ -z "$serverUrl" ]; then
    error "Server URL cannot be empty"
    exit 1
fi


CERT_FILE=$INT_RF/certs/$serverUrl".cert.pem"
CA_CHAIN=$INT_RF/certs/ca-chain.cert.pem

if [ ! -f $CERT_FILE ]; then
    error "Certificate file $CERT_FILE not found"
    exit 1
fi

openssl x509 -noout -text -in $CERT_FILE

info "Verifying CA certificate chain"

openssl verify -CAfile $CA_CHAIN $CERT_FILE

cd $CUR_DIR
