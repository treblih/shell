#!/bin/bash -
#=========================================================
#          FILE:  fvcom.sh
#   DESCRIPTION:  
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#         NOTES:  ---
#      REVISION:  ---
#         EMAIL: armx86@gmail.com
#       CREATED: 10.01.2011
#     COPYRIGHT: Copyright (c) 2011, Yang Zhang
#=========================================================
set -o nounset         # treat unset variables as an error

usage()
{
    cat << EOF
#### Make sure you're in the main directory of FVCOM2.7.x ####
EOF
}

dir=$(basename `pwd`)
if [ "${dir%.*}" != "FVCOM2.7" ]; then
    usage
    exit 1
fi
cd FVCOM_source
dos2unix *
patch -Np1 < ~/.fvcom_utils/fvcom.patch
cp ~/.fvcom_utils/libmetis.a ../METIS_source -fv
