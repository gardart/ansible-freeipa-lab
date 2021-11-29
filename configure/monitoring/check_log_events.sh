#!/usr/bin/env bash

##    This program is free software: you can redistribute it and/or modify
##    it under the terms of the GNU General Public License as published by
##    the Free Software Foundation, either version 3 of the License, or
##    (at your option) any later version.
##
##    This program is distributed in the hope that it will be useful,
##    but WITHOUT ANY WARRANTY; without even the implied warranty of
##    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##    GNU General Public License for more details.
##

# plugin return codes:
# 0     OK
# 1     Warning
# 2     Critical
# 3     Unknown

SEARCH_EVENT="ipa-backup command was successful"
NO_OF_SECONDS=86400       # 24 hours = 86400 seconds
LOG_FILE="/var/log/ipabackup.log"
LOG_TIMESTAMP_FORMAT="%Y-%m-%dT%H:%M:%S"

while getopts "hvw:c:" opt
do
        case $opt in
                h)
                        showhelp=1
                        break
                ;;
                w)
                        warning="$OPTARG"
                ;;
                c)
                        critical="$OPTARG"
                ;;
                v)
                        verbose=1
                ;;
        esac
done

printUsage() {
        echo "Usage: $0 [-h] [-v] -w <warning> -c <critical>"
        echo ""
        echo "Example: $0 -w 50 -c 100"
}

printHelp() {
        printUsage
        echo ""
        echo "This plugin checks the number of messages inside any file in the last x seconds."
        echo ""
        echo "For more details, see inside the script ;)"
        echo ""
        exit 3
}

if [ "$showhelp" = "1" ]; then
        printHelp
        exit 3
fi

if [ ! "$warning" ] || [ ! "$critical" ]; then
        printUsage
        exit 3
fi

if [ $warning -ge $critical ]; then
        echo "<warning> has to be smaller than <critical>!"
        exit 3
fi

if [ ! "$LOG_FILE" ]; then
        echo "File not found!"
        exit 3
fi

countEvents () {
        NOW=`date +%s`

        DATE_FROM=`awk -v now=$NOW -v seconds=$NO_OF_SECONDS -v LOG_TIMESTAMP_FORMAT=$LOG_TIMESTAMP_FORMAT 'BEGIN{print strftime(LOG_TIMESTAMP_FORMAT, now-seconds)}'`
        DATE_TO=`awk -v now=$NOW -v LOG_TIMESTAMP_FORMAT=$LOG_TIMESTAMP_FORMAT 'BEGIN{print strftime(LOG_TIMESTAMP_FORMAT, now)}'`

        echo `awk '$0>=from && $0<=to' from="$DATE_FROM" to="$DATE_TO" ${LOG_FILE} | grep "${SEARCH_EVENT}" -wc`
}

eventsCount=`countEvents`

echo "Events in the last $NO_OF_SECONDS seconds: $eventsCount | events=$eventsCount"

if [ "$eventsCount" -ge "$critical" ]; then
        exit 2
elif [ "$eventsCount" -ge "$warning" ]; then
        exit 1
else
        exit 0
fi
