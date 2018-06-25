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


CSR_FILE=$INT_RF/csr/$serverUrl".csr.pem"
CERT_FILE=$INT_RF/certs/$serverUrl".cert.pem"

if [ -f $CERT_FILE ]; then
    error "Certificate file $CERT_FILE already exists"
    exit 1
fi

if [ ! -f $CSR_FILE ]; then
    error "No certificate request file $CSR_FILE found"
    exit 1
fi


openssl ca -config $INT_OPENSSL_CFG -extensions server_cert -days 375 -notext -md sha256 -in $CSR_FILE -out $CERT_FILE

chmod 444 $CERT_FILE

cd $CUR_DIR
