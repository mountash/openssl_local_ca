#!/bin/bash

CUR_DIR=$PWD

source variables.sh
source helpers.sh

cd $RF

echo "Enter certificate file name (ex.: bjorn_mueller), followed by [ENTER]:"
read fileName

if [ -z "$fileName" ]; then
    error "File name cannot be empty"
    exit 1
fi

CSR_FILE=$INT_RF/csr/$fileName".csr.pem"
CERT_FILE=$INT_RF/certs/$fileName".cert.pem"

if [ -f $CERT_FILE ]; then
    error "Certificate file $CERT_FILE already exists"
    exit 1
fi

if [ ! -f $CSR_FILE ]; then
    error "No certificate request file $CSR_FILE found"
    exit 1
fi


openssl ca -config $INT_OPENSSL_CFG -extensions usr_cert -days 375 -notext -md sha256 -in $CSR_FILE -out $CERT_FILE -cert $INT_ROOT_CERT_CHAIN

chmod 444 $CERT_FILE

cd $CUR_DIR
