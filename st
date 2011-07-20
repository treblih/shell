#!/bin/bash - 
# STTMP (Please Do Not Change This Line, It Contains Metadata)
#
#===============================================================================
#
#          FILE:  st
# 
#         USAGE:  st filename1 filename2 ...
# 
#   DESCRIPTION:  1. auto choose a tool to open the corresponding file.
#		  2. open different file types at the same time,
#		     i.e. "st a.pdf b.mp3 c.txt".
#		  3. auto create ~/.strc
#		  4. request extra input only in 3 circumstances:
#		     new type never met; 			      (auto-modify st and ~/.strc)
#		     familiar type but not found the tool in ~/.strc; (auto-modify ~/.strc)
#		     tool not found in system or can't open the type; (same as above)
#		  5. incremental update, so no need user do it explicitly.
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#         NOTES:  ---
#      REVISION:  1.0
#         EMAIL: imyeyeslove@163.com
#       COMPANY: 
#       CREATED: 01.02.2010
#     COPYRIGHT: Copyright (c) 2010, Yang Zhang
#===============================================================================

# set -o nounset                             # Treat unset variables as an error



#===  FUNCTION  ================================================================
#          NAME:  Usage
#   DESCRIPTION:  tips of usage
#    PARAMETERS:  
#       RETURNS:  
#===============================================================================
Usage ()
{
	echo "ERROR: Usage: $0 filename1 filename2" >&2
	exit 1
}                                # ----------  end of function Usage  ----------


#===  FUNCTION  ================================================================
#          NAME:  where_am_i
#   DESCRIPTION:  auto modify st, so need to know where is st
#    PARAMETERS:  
#       RETURNS:  
#===============================================================================
where_am_i ()
{
	path=`which st`
	[ -z $path ] && 
	{
		echo -e "\nI don't know where am I, 'cause I need to know."
		echo -e 'put me in $PATH please.\n'
		exit 1
	} ||
        { path=${path%/*}; }
}	# ----------  end of function where_am_i  ----------


#===  FUNCTION  ================================================================
#          NAME:  check_load_strc
#   DESCRIPTION:  if ~/.strc exists but has no metadata, st will rebuild a
#		  new one, then load that.
#    PARAMETERS:  
#       RETURNS:  
#===============================================================================
check_load_strc ()
{
	nr=""
	strc=~/.strc$nr
	while [ -e $strc ] ; do
		meta=`gawk 'NR==1{print $2}' $strc`
		[[ "$meta" == "STRC" ]] && { . $strc; return 0; }

		#-------------------------------------------------------------------------------
		#  get here ==> $strc exists but have no metadata ==> may be user's original
		#  avoid destroyed, so find a new name space
		#-------------------------------------------------------------------------------
		[ "$nr" == "" ] && (( nr=0 )) || (( nr++ ))
		strc=~/.strc$nr
		not_strc=1
	done

echo -e "# STRC\n#
# NOTICE:
# 	METADATA in 1st line.
#	ST will check it every time to run.
#	If it changed, ST would rebuild a another using the model below, 
#	then load that every start. 
#
# Here are the patterns, u can follow this format to add new one.
# Good Day!\n\n
image='gpicview'
text='gvim'
music='exaile'
web='chromium-browser'
pdf='okular'
iso='quickiso'
zip='unzip'
rar='unrar e'
tgz='tar zxf'
tbz='tar jxf'" > $strc

		(( $? == 0 )) &&
		{
			echo -e "\nFirst time to run st."
			echo -e "~/.strc occupied, so I have made $strc."
			echo -e "No need to change $strc 'cause I can fix troubles in runtime."
			echo -e "Enjoy it!\n"
		} ||
		{
			echo -e "Making $strc failure. Please check!\n"
			exit 1
		}
		. ~/.strc                                               # done, source it
}	# ----------  end of function check_load_strc  ----------


#===  FUNCTION  ================================================================
#          NAME:  get_user_tool
#   DESCRIPTION:  get user input, which is user's preferd tools.
#    PARAMETERS:  
#       RETURNS:  
#===============================================================================
get_user_tool ()
{
	echo -e "Which tool u perfer to open it?"
	echo -e "Can also use args, i.e. 'tar -zxf' (no single quotes)"
	read tool                                    # ask user to input
}	# ----------  end of function get_usr_tool  ----------


#===  FUNCTION  ================================================================
#          NAME:  get_safe_tmp
#   DESCRIPTION:  find safe ~/.sttmpN, avoid destroyed user's original file.
#		  every time when st wanna create a tmp file named ~/.sttmpN,
#		  get_safe_tmp would help to get the appropriate one.
#			
#		  just appears in 2 spaces:
#		  1. never_met		    for st    (wait for the last second)
#		  2. not_found_or_cant_open for $strc (disappear at once when done)
#    PARAMETERS:  
#       RETURNS:  
#===============================================================================
get_safe_tmp ()
{
	sttmp=~/.sttmp$nr
	while [ -e $sttmp ]; do
		meta=`gawk 'NR==2{print $2}' $sttmp`
		[ "$meta" == "STTMP" ] && lastnr=$nr
		(( nr++ ))
		sttmp=~/.sttmp$nr
	done
}	# ----------  end of function get_safe_tmp  ----------


#===  FUNCTION  ================================================================
#          NAME:  auto_modify
#   DESCRIPTION:  auto modification in 3 circumstances
#    PARAMETERS:  never_met; met_but_miss; not_found_or_cant_open
#       RETURNS:  
#===============================================================================
auto_modify ()
{
	case $1 in
		#-------------------------------------------------------------------------------
		#  i.e. we meet a new type *.pnng, auto add:
		# 
		#  *.pnng)
		#  tool=$pnng ;;	in st
		#  
		#  pnng='picviewer'	in $strc (if u type "picview" when being asked)
		#-------------------------------------------------------------------------------
		never_met)
		echo -e "\n\"*.$file_type\", new file type I have never met.\n"
		get_user_tool
		echo NOT REEEDDD
		get_safe_tmp
		#-------------------------------------------------------------------------------
		#  as long as a .sttmpN with STTMP found, lastnr would not b ""
		#-------------------------------------------------------------------------------
		[[ "$lastnr" == "" ]] && lasttmp=$path/st || lasttmp=~/.sttmp$lastnr

		#-------------------------------------------------------------------------------
		#  add pattern under "# ... I Must B Here" in st
		#-------------------------------------------------------------------------------
		eval "sed '/#.*A\sUnique\sFlag\./ a\ \t\t*.$file_type)\n\t\ttool=\$$file_type ;;' \
		      $lasttmp" > $sttmp
		chmod u+x $sttmp
		echo "$file_type='$tool'" >> $strc         # add default tools in $strc
		# overlay_flag=1
		;;

		#-------------------------------------------------------------------------------
		#  .bmp... are file_type, and they bond with same tool, avoid giving every
		#  file_type a case opt, i regard them as in a file_class named "image".
		#
		#  if lost the item "image='gpicview'" in ~/.strc, of course we'll get here.
		#  see above, if add the item in ~/.strc just use the method in "never_met":
		#  
		#  $ st a.jpg	--> jpg="gpicview" added in ~/.strc
		# 
		#  then next time "st a.jpg", st also tell u "i know the type but miss the tool".
		#  st will check "image='...'" in ~/.strc, not the new one "jpg"
		#
		#  1st, find the line containing ".jpg" in st
		#  2nd, find the line containing "tool..." under it line by line
		#  3rd, cut the file_class
		#  4th, add the file_class as a new item in ~/.strc
		#-------------------------------------------------------------------------------
		met_but_miss)
		echo
		echo "I know \"*.$file_type\", but miss the corresponding tool. Wrong in ~/.strc."
		echo
		get_user_tool

		#-------------------------------------------------------------------------------
		#  EGREP/FGREP, choose one.
		#  -n -- print the line num, 'cause we need it.
		#-------------------------------------------------------------------------------
		line=`eval fgrep -n '\*\."$file_type"' $path/st`
		# line=`eval egrep -n '\\\*\\\."$file_type"' $path/st`

		line=${line%%:*}                                # %%, not %
		line_max=`wc -l $path/st`
		line_max=${line_max%% *}
		name=""
		while [[ -z $name ]] ; do                       # line by line
			name=`eval gawk '"NR==$line"' $path/st | fgrep '=$'`
			# name=`eval gawk "'NR==$line'" $path/st | fgrep '=$'`
			(( line++ ))
			[[ $line == $line_max ]] && exit 1
		done

		file_class=`echo $name | sed 's/.*=\$\(\w*\)\s*;;/\1/'`
		echo "$file_class='$tool'" >> $strc         # add default tools in ~/.strc
		;;

		not_found_or_cant_open)
		echo -e "\n\"$tool\" not found in u system, or can't open this type\n"
		delete=$tool
		get_user_tool
		get_safe_tmp
		echo $sttmp
		#-------------------------------------------------------------------------------
		#  if GGG not found in sys, found it in ~/.strc then substitute it.
		#-------------------------------------------------------------------------------
		# eval "sed 's/\(=.\)$delete\(.\)$/\1$tool\2/' $strc" > $sttmp
		eval "sed 's/\(=.\)$delete\(.\)$/\1$tool\2/' $strc > $sttmp"
		echo $strc
		echo $sttmp
		mv $sttmp $strc
		;;

		*)
		exit 1
		;;
	esac    # --- end of case ---

	. $strc
	echo -e "\nOK! Use \"$tool\" to open \"*.$file_type\". I have remembered.\n"
}	# ----------  end of function auto_modify  ----------


#===  FUNCTION  ================================================================
#          NAME:  clear_all_tmp
#   DESCRIPTION:  
#    PARAMETERS:  
#       RETURNS:  
#===============================================================================
clear_all_tmp ()
{
	is_clear=1
	sttmp=~/.sttmp$nr
	while (( 1 )); do
		[ -e $sttmp ] &&
		{
			meta=`gawk 'NR==2{print $2}' $sttmp`
			[[ "$meta" == "STTMP" ]] &&
			{
				echo holy
				[ "$is_clear" == 1 ] && { overlay=$sttmp; is_clear=0; } ||
				rem $sttmp
			}
			[[ "$meta" == "STRC" ]] && rem $sttmp
		}
		(( nr-- ))
		(( $nr>=0 )) && sttmp=~/.sttmp$nr || break
	done

	[ -n "$overlay" ] && exec mv $overlay $path/st
	# [ -n $overlay ] && exec mv $overlay $path/st
	exit 0
}	# ----------  end of function clear_all_tmp  ----------



#-------------------------------------------------------------------------------
#				Get Started
#  			    is it the 1st time?
#-------------------------------------------------------------------------------
(( $# == 0 )) && Usage "$0" 

where_am_i && check_load_strc

# trap 'echo hhh' 17
nr=0
pc=0
# set -m
trap 'wait $!; pc=$?; echo $pc' CHLD
#-------------------------------------------------------------------------------
#  open files 1 by 1
#-------------------------------------------------------------------------------
#for file_name in $* ; do
for file_name in $@ ; do
	file_type=${file_name##*.}                      # notice, ## not #, a.tar.gz

	#-------------------------------------------------------------------------------
	#  all file types here.
	#
	#  NOTICE:
	#	st will add new types here just under the "case $file_name in"
	#-------------------------------------------------------------------------------
	case $file_name in
	#  I'm A Unique Flag. I Must Be Here. Don't Edit Me.
		*.c | *.cpp)
		tool=$ccompiler ;;
 		*.chm)
		tool=$chm ;;
 		*.gz)
		tool=$gz ;;
 		*.tgz)
		tool=$tgz ;;
 		*.png)
		tool=$png ;;
 		*.jpg)
		tool=$jpg ;;
		*.bmp | *.gif) 
		tool=$image ;;
		*.txt | *.vim | *.vimrc | *.cflow | *.c | *.[Hh] | *.[Cc][Pp][Pp] | \
		*.[Ss][Hh] | *.[Pp][Yy] | *.[Pp][Hh][Pp]) 
		tool=$text ;;
		*.mp3 | *.wma) 
		tool=$music ;;
		*.htm* | *.php | *.asp*) 
		tool=$web ;;
		*.pdf) 
		tool=$pdf ;;
		*.iso) 
		tool=$iso ;;
		*.zip) 
		tool=$zip ;;
		*.rar) 
		tool=$rar ;;
		*.tar.gz) 
		tool=$tgz ;;
		*.tbz | *.tar.bzip2 | *.tar.bz | *.tar.bz2) 
		tool=$tbz ;;

		#-------------------------------------------------------------------------------
		#  quick sleep and hibernation.
		#  notice, EXEC
		#-------------------------------------------------------------------------------
		sleep)
		exec su -c 'echo mem > /sys/power/state' ;;
		hibernation)
		exec su -c 'echo disk > /sys/power/state' ;;

		#-------------------------------------------------------------------------------
		#  default, means meet a new file type.
		#
		#  rewrite: 	~/.strc	st
		#-------------------------------------------------------------------------------
		*)
		auto_modify "never_met" ;;
        esac                                                    # --- end of case ---
	
	#-------------------------------------------------------------------------------
	#  getting here, proves not a new file type, so prepare to open it.
	#  if $tool == "", there must be sth. wrong in ~/.strc
	#
	#  rewrite:	~/.strc
	#-------------------------------------------------------------------------------
	[[ -z $tool ]] && auto_modify "met_but_miss"

	#-------------------------------------------------------------------------------
	#  our error msg instead of sys
	#  until u tool could open it
	# 
	#  but this must to wait for every execution
	#  if use "&", $? always == 0....
	#  how to deal with it???
	#-------------------------------------------------------------------------------
	$tool $file_name &
	while [ "$pc" != 0 ]; do
		auto_modify "not_found_or_cant_open"
		$tool $file_name &
		wait $!
	done
done

#-------------------------------------------------------------------------------
#  only apply in "never_met" 'cause need to rewrite st.
#  st disappear while overlay itself.
#
#  though could overlay st when executing, but bad aesthetics in my opinion.
#-------------------------------------------------------------------------------
clear_all_tmp



#-------------------------------------------------------------------------------
# TODO:
# trim fgrep exec
# exec advantage poweroff overlay
# metadata ~/.strc
# eval "sed '/#.*Flag.*Me.*$/ a\ \t\t*.$file_type)\n\t\ttool=\$$file_type ;;' $path/st" >| ~/.sttmp 
# eval "sed 's/\(=.\)$delete\(.\)\s*/\1$tool\2/' ~/.strc" >| ~/.sttmp
# eval "sed 's/\(=.\)$delete\(.\)\s*/\1$tool\2/' ~/.strc >| ~/.sttmp"
# sed ' in pattern
# diff exit staus
# same tool in same class
# secure making ~/.rc ~/.tmp
# auto delete ~/.tmp
# enhanced RE
#-------------------------------------------------------------------------------
