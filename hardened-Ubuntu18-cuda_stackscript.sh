#!/bin/bash
#
#
#<UDF name="ssuser" Label="Sudo user username?" example="username" />
#<UDF name="sspassword" Label="Sudo user password?" example="strongPassword" />
#<UDF name="sspubkey" Label="SSH pubkey (installed for root and sudo user)?" example="ssh-rsa ..." />

wget https://github.com/lsisoft/demo/blob/master/hardened-Ubuntu18-cuda.sh

source hardened-Ubuntu18-cuda.sh 2>&1 | tee ~/stackscript_progress.log