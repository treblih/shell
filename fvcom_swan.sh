#!/bin/bash - 
#=========================================================
#          FILE:  qhzhao
#   DESCRIPTION:  
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#         NOTES:  ---
#      REVISION:  ---
#       CREATED: 08.10.2011
#     COPYRIGHT: Copyright (c) 2011, Qiaohua Zhao
#=========================================================

SLEEP=30
D_NONE="\033[m"
D_RED="\033[0;32;31m"
D_GREEN="\033[0;32;32m"
D_BLUE="\033[0;32;34m"

INPUT=~/INPUT_ZQH
FVCOM=~/FVCOM_WQ_TEST
SWAN=~/swan_zqh
WATER=~/waterquality/WQM/DATA

INPUT_EXE=input.exe
SWAN_EXE=swan.exe
FVCOM_EXE="mpirun -np 2 ../FVCOM_source/fvcom chn"
PREPROCESS_EXE=PREPROCESS.exe
SC_NEW3_EXE=SC_NEW3.exe

is_run()
{
    res=`ps aux | grep $1 | wc -l`
    if [[ $res > 1 ]]; then
        echo running   
    fi
}

# in $INPUT
cd $INPUT
./$INPUT_EXE >& /dev/null &
#./$INPUT_EXE &
while [[ `is_run $INPUT_EXE` ]]; do
    echo -e "${D_RED}$INPUT_EXE is running, please wait${D_NONE}"
    sleep $SLEEP
done
echo -e "${D_GREEN}$INPUT_EXE is done${D_NONE}"
cp ./result-2010temp.txt $SWAN
cp ./chn-evp.dat ./chn_hfx.dat ./chn_hfx_air.dat ./chn_initial_wqm.dat ./chn_wnd.dat $FVCOM/run/CHANNEL

# in $SWAN
cd $SWAN
./$SWAN_EXE >& /dev/null &
#./$SWAN_EXE &
while [[ `is_run $SWAN_EXE` ]]; do
    echo -e "${D_RED}$SWAN_EXE is running, please wait${D_NONE}"
    sleep $SLEEP
done
echo -e "${D_GREEN}$SWAN_EXE is done${D_NONE}"

# in $FVCOM/run
cd $FVCOM/run
./$FVCOM_EXE >& /dev/null &
#./$FVCOM_EXE &
while [[ `is_run $FVCOM_EXE` ]]; do
    echo -e "${D_RED}$FVCOM_EXE is running, please wait${D_NONE}"
    sleep $SLEEP
done
echo -e "${D_GREEN}$FVCOM_EXE is done${D_NONE}"

echo -e "${D_BLUE}Transfering a lot of resuting files, please wait${D_NONE}"
cp $FVCOM/run/sms* $WATER

# in $WATER/WQM
cd $WATER/WQM
./$PREPROCESS_EXE >& /dev/null &
#./$PREPROCESS_EXE &
while [[ `is_run $PREPROCESS_EXE` ]]; do
    echo -e "${D_RED}$PREPROCESS_EXE is running, please wait${D_NONE}"
    sleep $SLEEP
done
echo -e "${D_GREEN}$PREPROCESS_EXE is done${D_NONE}"

./$SC_NEW3_EXE >& /dev/null &
#./$SC_NEW3_EXE &
while [[ `is_run $SC_NEW3_EXE` ]]; do
    echo -e "${D_RED}$SC_NEW3_EXE is running, please wait${D_NONE}"
    sleep $SLEEP
done
echo -e "${D_GREEN}$SC_NEW3_EXE is done${D_NONE}"

echo -e "${D_BLUE}All success!${D_NONE}"
