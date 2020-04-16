#!/bin/bash
#
#
#<UDF name="ssuser" Label="Sudo user username?" example="username" />
#<UDF name="sspassword" Label="Sudo user password?" example="strongPassword" />
#<UDF name="sspubkey" Label="SSH pubkey (installed for root and sudo user)?" example="ssh-rsa ..." />

# include StackScript Bash Library
source <ssinclude StackScriptID=1>

wget https://raw.githubusercontent.com/lsisoft/demo/master/hardened-Ubuntu18.sh

source hardened-Ubuntu18.sh 2>&1 | tee ~/stackscript_progress.log