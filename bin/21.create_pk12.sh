#!/bin/bash

CUR_DIR=$PWD

source variables.sh
source helpers.sh

cd $RF

echo "Enter path to certificate file (ex.: /opt/ca/cert/example.cert.pem), followed by [ENTER]:"
read certFile

if [ -z "$certFile" ]; then
    error "File path cannot be empty"
    exit 1
fi

if [ ! -f $certFile ]; then
    error "Cannot find certificate file $certFile"
    exit 1
fi

echo "Enter path to key file (ex.: /opt/ca/private/example.key.pem), followed by [ENTER]:"
read keyFile

if [ -z "$keyFile" ]; then
    error "File path cannot be empty"
    exit 1
fi

if [ ! -f $keyFile ]; then
    error "Cannot find key file $keyFile"
    exit 1
fi

echo "Enter path for pk12 file to save (ex.: /opt/ca/pk12/example.pfx), followed by [ENTER]:"
read pfxFile

if [ -z "$pfxFile" ]; then
    error "File path cannot be empty"
    exit 1
fi

if [ -f $pfxFile ]; then
    error "PFX file $pfxFile already exists"
    exit 1
fi

info "Creating container"

openssl pkcs12 -export -inkey $keyFile -in $certFile -out $pfxFile

cd $CUR_DIR
