#!/bin/bash

CUR_DIR=$PWD

source helpers.sh

function printVariables {
    info "Country: $COUNTRY"
    info "State: $STATE"
    info "Organization $ORGANIZATION"
    info "Organiszation unit: $ORG_UNIT"
    info "Certificate Revocation List distribution point URL: $CRL_URL"
    info "Root folder: $RF"
    info "Root key file: $ROOT_KEY_FILE"
    info "Root certificate file: $ROOT_CERT_FILE"
    info "OpenSSL configuration file: $OPENSSL_CFG"
    info "======"
    info "Intermediate CA folder: $INT_RF"
    info "Intermediate key file: $INT_KEY_FILE"
    info "Intermediate certificate request file: $INT_CERT_REQ_FILE"
    info "Intermediate certificate file: $INT_CERT_FILE"
    info "Intermediate OpenSSL configuration file: $INT_OPENSSL_CFG"
}

function createDirectories {
    cd $RF
    info "Creating folders: mkdir certs crl newcerts private"
    mkdir certs crl newcerts private
    info "Setting access of private folder to 700"
    chmod 700 private
    info "Creating flat file database for to keep track of signed certificates"
    touch index.txt
    echo 1000 > serial
}

function createOpenSSLConf {
    info "Creating OpenSSL configuration file"
    cd $RF
    cp $CUR_DIR/openssl.cnf.template $RF/openssl.cnf
    sed -i -e 's@{FOLDER}@'"$RF"'@g' $RF/openssl.cnf
    sed -i -e 's@{CRL_URL}@'"$CRL_URL"'@g' $RF/openssl.cnf
    sed -i -e 's/{COUNTRY}/'"$COUNTRY"'/g' $RF/openssl.cnf
    sed -i -e 's/{STATE}/'"$STATE"'/g' $RF/openssl.cnf
    sed -i -e 's/{ORGANIZATION}/'"$ORGANIZATION"'/g' $RF/openssl.cnf
    sed -i -e 's/{ORG_UNIT}/'"$ORG_UNIT"'/g' $RF/openssl.cnf
}

if [ ! -f variables.sh ]; then
    error "variables.sh script not found! Please create it using variables.sh.template"
else
    info "Loading variables..."
    source variables.sh
    printVariables
    if [ -d "$RF" ]; then
        info "Root folder $RF is already exists!"
    else
        mkdir $RF
        info "Root folder $RF created"         
    fi
    if [ ! -z "$(ls -A $RF)" ]; then
        error "Root folder $RF is not empty. Exiting"
        exit 1
    fi
    createDirectories
    createOpenSSLConf
    cd $CUR_DIR
fi

