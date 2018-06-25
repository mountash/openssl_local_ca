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

KEY_FILE=$INT_RF/private/$fileName".key.pem"
CSR_FILE=$INT_RF/csr/$fileName".csr.pem"

if [ -f $KEY_FILE ]; then
    error "Key file $KEY_FILE already exists"
    exit 1
fi

info "Creating client key in $KEY_FILE"

openssl genrsa -aes256 -out $KEY_FILE 2048

info "Creating certificate signing request"

openssl req -config $INT_OPENSSL_CFG -key $KEY_FILE -new -sha256 -out $CSR_FILE

cd $CUR_DIR
