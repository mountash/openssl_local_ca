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

KEY_FILE=$INT_RF/private/$serverUrl".key.pem"
CSR_FILE=$INT_RF/csr/$serverUrl".csr.pem"

if [ -f $KEY_FILE ]; then
    error "Key file $KEY_FILE already exists"
    exit 1
fi

echo "Do you want to protect the key by password?"
echo ""
echo "If you’re creating a cryptographic pair for use with a web server (eg, Apache)," 
echo "you’ll need to enter this password every time you restart the web server."
echo "[y/n]?"

read withPass

# You may want to omit the -aes256 option to create a key without a password.

echo ""

info "Creating server sertificate for $serverUrl"

if [ "$withPass" = "y" ] || [ "$withPass" = "yes" ] ; then
    info "with password protection"
    openssl genrsa -aes256 -out $KEY_FILE 2048
else
    info "without password protection"
    openssl genrsa -out $KEY_FILE 2048
fi

info "Creating certificate signing request"

openssl req -config $INT_OPENSSL_CFG -key $KEY_FILE -new -sha256 -out $CSR_FILE

cd $CUR_DIR
