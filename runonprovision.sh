#!/bin/vbash
#delete runonprovision task

readonly logFile="/var/log/runonprovision.log"

source /opt/vyatta/etc/functions/script-template

configure > ${logFile}
delete system task-scheduler task runonprovision  >> ${logFile}
commit >> ${logFile}
save >> ${logFile}
#exit

#download reboot script. cannot create task schedule before file exists
/usr/bin/curl --silent 'https://raw.githubusercontent.com/computerwarriorsits/UnifiUSGReboot/reboot.sh' > /config/scripts/reboot.sh
/bin/chmod +x /config/scripts/reboot.sh

#add task to run every Sunday at 3am
touch /var/spool/cron/crontabs/root
{ crontab -l; echo "0 3 * * 7 /config/scripts/restartvpn.sh"; } | crontab -
