#!/bin/bash
# end a command with ; to run in a terminal

DMENU="dmenu -i "
TERMI="urxvtc -e"
CACHE="$HOME/.dmenu_cache_recent"

touch $CACHE
MOST_USED=`sort $CACHE | uniq -c | sort -r | colrm 1 8`
RUN=`(echo "$MOST_USED"; dmenu_path | grep -vxF "$MOST_USED") | $DMENU $@` &&
(echo $RUN; head -n 99 $CACHE) > $CACHE.$$ &&
mv $CACHE.$$ $CACHE

case $RUN in
    *\;) exec `echo $TERMI $RUN | sed -e 's/;$//'`;;
    *)   exec $RUN;;
esac
