#!/bin/bash

TIMEOUT=100
SLEEP=0.1

echo -n "Waiting up to $(($TIMEOUT/10)) seconds for snapd startup "
while [ $(systemctl status snapd.seeded >/dev/null 2>&1; echo $?) != "0" ]; do
    echo -n "."
    sleep $SLEEP || clean_up
    if [ "$TIMEOUT" -le "0" ]; then
        echo " Timed out!"
        exit 1
    fi
    TIMEOUT=$(($TIMEOUT-1))
done
echo " done"
exit 0
