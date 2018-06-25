#!/bin/bash

CUR_DIR=$PWD

source variables.sh
source helpers.sh

cd $RF

if [ -f $INT_CRL ]; then
    info "Certificate Revocation List file $INT_CRL already exists. Removing..."
    rm $INT_CRL	    
fi

info "Creating Certificate Revocation List file in $INT_CRL"

openssl ca -config $INT_OPENSSL_CFG -gencrl -out $INT_CRL

openssl crl -in $INT_CRL -noout -text

info "You should re-create the CRL at regular intervals. By default, the CRL expires after 30 days."
info "This is controlled by the default_crl_days option in the [ CA_default ] section."

cd $CUR_DIR
