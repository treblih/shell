#!/bin/bash - 
#=========================================================
#          FILE:  a.sh
#   DESCRIPTION:  
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#         NOTES:  ---
#      REVISION:  ---
#         EMAIL: armx86@gmail.com
#       CREATED: 13.07.2011
#     COPYRIGHT: Copyright (c) 2011, Yang Zhang
#=========================================================

for file in `find . -maxdepth 1 -type f`
do 
    suffix=${file:(-3)}
    if [[ $suffix != ".sh" && $suffix != ".py" ]]; then
        not_found=`ldd $file | grep "not found"`
        if [[ -n $not_found ]]; then
            echo $file
            echo "$not_found"
        fi
    fi
done
