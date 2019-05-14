#!/bin/bash
#       Author : Raghav Chauhan
#       Version : 1.0
#       Email: Raghav.chauhan78@gmail.com
#       github: https://github.com/rv8979/autobackup
#       Autobackup script
#
#



#-----------------
#   Variables
#-----------------

myip=$(wget -qO - icanhazip.com)
#llip="103.99.196.174"
IP=$(/sbin/ip route | awk '/default/ { print $3 }')
server_ip=""
user_name="rv"               # edit user name
ssh_user="backup-pc"         # edit backup server username
backup_date=""

start_backup () {
  ssh $ssh_user@$server_ip mkdir /backup/$user_name/$(date '+%d-%b-%Y')
  backup_date=/backup/$user_name/$(date '+%d-%b-%Y')
  #rsync -av --delete -e ssh ~/.thunderbird $ssh_user@$server_ip:/backup/$user_name
  rsync -av --delete -e ssh ~/.thunderbird $ssh_user@$server_ip:$backup_date
  printf "================Backup success================ \n"
  printf "============================================== \n"
  printf "============================================== \n"
  exit 0;
}

mkdir_f (){
  ssh $ssh_user@$server_ip mkdir /backup/$user_name
  start_backup
}

#---------------
# write some text for log file

printf " \n"
printf " \n"
printf "======================================== \n"
printf "=========================================\n"
printf "Backup Date `date` \n"
printf "\n"

#------------------------------
# Check current connection

if [[ $myip =~ ^[103]+\.[99]+\.[196]+\.[174]+$ ]]; then  # static ip
  printf "Current connection :  Lease Line \n"
  server_ip="192.168.1.51"


elif [[ $myip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then # dynamic ip
  printf "Current connection : Excitel Broadband \n"
  server_ip="192.168.2.99"

else
  printf "error....: You are not connect any internet or may be internet not working \n"
  exit 1;
fi


if ! ping -q -c 3 $server_ip > /dev/null 2>&1; then
	echo -e "Error: Could not reach Backup server, please check your internet connection and run this script again" >&2
	exit 1;
fi

#echo "$`date +%e``date +%m``date -%g`"
#mkdir $(date '+%d-%b-%Y')
#date '+%d-%b-%Y'

#==========================
# Check user folder exist or not

ssh $ssh_user@$server_ip [ -d "/backup/$user_name" ] && start_backup || mkdir_f

#[ -d "/backup/guddu" ] && echo "exists." || echo "Error: Directory /path/to/dir does not exists."
#[ -d "/backup/$user_name" ] && echo "exists." || echo "Error: Directory /path/to/dir does not exists."
start_backup
