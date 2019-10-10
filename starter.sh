#!/bin/bash

_zenity="/usr/bin/zenity"
_out="./whois.output.$$"
_bash="/bin/bash"
_script="./backup_script.sh"
_pidof=""


#------------
# Check thunderbird is running
#------------------
_pidof=$(pidof thunderbird)


if [ $_pidof != "" ];
then
ps -ef | grep thunderbird | grep -v grep | awk '{print $2}'| xargs kill -9
fi



${_bash} $_script  | tee >(${_zenity} --width=200 --height=100 \
                          --title="Creating Backup" --progress \
                          --pulsate --text="file copy" \
                          --auto-kill --auto-close --no-cancel \
                          --percentage=10) >${_out}

  ${_zenity} --width=800 --height=600  \
             --title "Backup Log" \
	         --text-info --filename="${_out}"
