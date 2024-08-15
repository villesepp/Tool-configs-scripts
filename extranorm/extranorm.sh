#!/bin/zsh
FINDS=0
TESTCOUNTER=0
LOGFILE="extranorm"
ARGUMENTS=(
	"printf"
	"delete"
	"todo"
	"this"
	"marvin"
	"//"
	"(void) "
	"deb"
)

# colors
GRN="\033[1;32m"
RED="\033[1;31m"
RST="\033[0m"

echo "⚡ Looking for the following:"
# display arguments
for ARG in "${ARGUMENTS[@]}"
do
	echo -n "$ARG "
done
echo

# run grep
for ARG in "${ARGUMENTS[@]}"
do
	if grep -r -l --include "*.c" --include "*.h" $ARG . ; then
	    echo "⚡ \"${RED}$ARG${RST}\" was found in the above !"
		FINDS=$((FINDS + 1)) 
		echo ""
	fi
done


# report 
if [ $((FINDS)) -gt 0 ]; then
	echo "⚡ ${RED}There were $FINDS matches.${RST}"
else
	echo "⚡ ${GRN}Nothing found.${RST}"
fi

# echo "⚡ ${TESTCOUNTER} Valgrind logs written as ${LOGFILE}[i]."
