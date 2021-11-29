#!/bin/bash

type ipa-healthcheck      >/dev/null 2>&1 || { echo >&2 "CRITICAL: The ipa-healthcheck utility is required for this script to run."; exit 2; }

function usage {
cat <<EOF
Usage ./check_ipa_health.sh [-s <Source of checks, e.g. ipahealthcheck.foo.bar>]
Options:
  -s <SOURCE>  # Required 
EOF
exit 2
}

while getopts ":s:o:h" OPTIONS; do
        case "${OPTIONS}" in
                s) SOURCE=${OPTARG} ;;
                o) EXTRAOPTIONS=${OPTARG} ;;
                h) usage ;;
                *) usage ;;
        esac
done

EXITCODE=0

function returnResult () {
  CHECKSTATUS="$1"
  if [[ "$CHECKSTATUS" == "Critical" ]] && [[ $EXITCODE -le 2 ]]; then
    RESULT=$(echo -e "$CHECKSTATUS: $CHECK\n$RESULT")
    EXITCODE=2
  elif [[ "$CHECKSTATUS" == "Warning" ]] && [[ $EXITCODE -ge 2 ]]; then
    RESULT=$(echo -e "$CHECKSTATUS: $CHECK\n$RESULT")
    EXITCODE="$EXITCODE"
  elif [[ "$CHECKSTATUS" == "Warning" ]] && [[ $EXITCODE -le 1 ]]; then
    RESULT=$(echo -e "$CHECKSTATUS: $CHECK\n$RESULT")
    EXITCODE=1
  fi
}

CHECKS=$(ipa-healthcheck --failures-only --output-type human --source $SOURCE $EXTRAOPTIONS)

#*ipahealthcheck.ipa.trust.IPATrustCatalogCheck.S-1-5-21-894253103-312285852-903097961*) returnResult OK;;

IFS=$'\n'
for CHECK in ${CHECKS}; do
  case "$CHECK" in
    CRITICAL:*) returnResult Critical;;
    ERROR:*) returnResult Critical;;
    WARNING:*) returnResult Warning;;
    *) returnResult OK;;
  esac
done

case $EXITCODE in
  0) printf "OK" ;;
  1) printf "" ;;
  2) printf "" ;;
esac

echo "$RESULT"
exit $EXITCODE

