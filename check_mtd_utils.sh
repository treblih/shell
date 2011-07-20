#!/bin/bash - 
#=========================================================
#          FILE:  check_mtd_utils.sh
#   DESCRIPTION:  
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#         NOTES:  ---
#      REVISION:  ---
#         EMAIL: armx86@gmail.com
#       CREATED: 26.01.2011
#     COPYRIGHT: Copyright (c) 2011, Yang Zhang
#=========================================================

utils=(docfdisk      flash_eraseall  flash_otp_info  jffs2dump   mtdinfo    nftldump     rfdformat    ubicrc32   ubinfo     ubirsvol
doc_loadbios  flash_info      flash_unlock    mkfs.jffs2  nanddump   nftl_format  serve_image  ubidetach  ubinize    ubiupdatevol
flashcp       flash_lock      ftl_check       mkfs.ubifs  nandtest   recv_image   sumtool      ubiformat  ubirename
flash_erase   flash_otp_dump  ftl_format      mtd_debug   nandwrite  rfddump      ubiattach    ubimkvol   ubirmvol)

for tool in ${utils[@]}; do
    file /usr/sbin/${tool}
done
