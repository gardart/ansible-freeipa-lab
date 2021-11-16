#!/bin/bash

### ======================================================================= ###
###     A nagios plugin to check ipa health                                 ###
###     Uses: ./check_ipa_health.sh ipahealthcheck.ds.replication           ###
### ======================================================================= ###

### ======================================================================= ###
###                         FUNCTIONS                                       ###
### ======================================================================= ###

ipa_health_check(){
        #RESULTS=`ipa-healthcheck --output-type human --failures-only --source ${SOURCE}`
  RESULTS=`cat text.txt`
  RESULTS_CRITICAL_COUNT=$(echo "$RESULTS" | grep CRITICAL: | wc -l)
  RESULTS_ERROR_COUNT=$(echo "$RESULTS" | grep ERROR: | wc -l)
  RESULTS_WARNING_COUNT=$(echo "$RESULTS" | grep WARNING: | wc -l)
  echo $RESULTS_CRITICAL_COUNT
  echo $RESULTS_WARNING_COUNT
  echo $RESULTS_ERROR_COUNT
        case ${RESULTS} in
        "")
                        echo "OK - All checks ran successfully"
                        exit 0
                        ;;
        CRITICAL*)
                        echo "CRITICAL - ${RESULTS}"
                        exit 2
                        ;;
        ERROR*)
                        echo "CRITICAL - ${RESULTS}"
                        exit 2
                        ;;
        WARNING*)
                        echo "WARNING - ${RESULTS}"
                        exit 1
                        ;;
        *)
                        echo "UNKNOWN - ${RESULTS}"
                        exit 3
                        ;;
        esac
}

### ======================================================================= ###
###                         SCRIPT EXECUTION START HERE                     ###
### ======================================================================= ###

if [[ -z "$1" ]]
then
        echo "Missing parameters! Syntax: ./`basename $0` source"
        exit 3
else
        SOURCE=$1
fi

ipa_health_check

### ======================================================================= ###
###                         END OF SCRIPT                                   ###
### ======================================================================= ###
