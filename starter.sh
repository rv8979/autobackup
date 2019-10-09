#!/bin/bash

_zenity="/usr/bin/zenity"
_out="/tmp/whois.output.$$"
_bash="/bin/bash"
_script="/home/raghav/Desktop/cc/backup_script.sh"
_pidof=""


#------------
# Check thunderbird is running
_pidof=$(pidof thunderbirt)

if {_pidof -ne ""} then 
 pkill -9 _pidof


${_bash} $_script  | tee >(${_zenity} --width=200 --height=100 \
                          --title="Creating Emails



 Backup" --progress \
                          --pulsate --text="file copy" \
                          --auto-kill --auto-close --no-cancel \
                          --percentage=10) >${_out}

cp $_out ~/Desktop/cc/
  ${_zenity} --width=800 --height=600  \
             --title "Backup Log" \
	         --text-info --filename="${_out}"
