#!/bin/bash

CUR_DIR=$PWD

source helpers.sh

function createDirectories {
    cd $INT_RF
    info "Creating folders: certs crl csr newcerts private"
    mkdir certs crl csr newcerts private
    info "Setting access of private folder to 700"
    chmod 700 private
    info "Creating flat file database for to keep track of signed certificates"
    touch index.txt
    echo 1000 > serial
    echo 1000 > $INT_RF/crlnumber
}

function createOpenSSLConf {
    info "Creating OpenSSL configuration file"
    cd $INT_RF
    cp $CUR_DIR/inter.openssl.cnf.template $INT_RF/openssl.cnf
    sed -i -e 's@{FOLDER}@'"$INT_RF"'@g' $INT_RF/openssl.cnf
    sed -i -e 's@{CRL_URL}@'"$CRL_URL"'@g' $INT_RF/openssl.cnf
    sed -i -e 's/{COUNTRY}/'"$COUNTRY"'/g' $INT_RF/openssl.cnf
    sed -i -e 's/{STATE}/'"$STATE"'/g' $INT_RF/openssl.cnf
    sed -i -e 's/{ORGANIZATION}/'"$ORGANIZATION"'/g' $INT_RF/openssl.cnf
    sed -i -e 's/{ORG_UNIT}/'"$ORG_UNIT"'/g' $INT_RF/openssl.cnf
}

source variables.sh
if [ -d "$INT_RF" ]; then
   info "Intermediate folder $INT_RF is already exists!"
else
   mkdir $INT_RF
   info "Intermediate folder $INT_RF created"         
fi
if [ ! -z "$(ls -A $INT_RF)" ]; then
   error "Intermediate folder $INT_RF is not empty. Exiting"
   exit 1
fi
createDirectories
createOpenSSLConf
cd $CUR_DIR

