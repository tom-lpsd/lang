#!/bin/bash

xday=$(date -d $1 '+%s')
now=$(date '+%s')
diff=$((xday-now))
secoff=$((diff % 86400))
minoff=$((secoff % 3600))
echo -n "xdayまで後 "
echo $((diff/86400)) "日と" $((secoff/3600)) "時間" $((minoff/60 - 1)) "分"
