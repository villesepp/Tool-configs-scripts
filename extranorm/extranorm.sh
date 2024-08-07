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
)

# colors
GRN="\033[1;32m"
RED="\033[1;31m"
RST="\033[0m"

echo "⚡ Extra norm check starting"
echo ""

# run grep
for ARG in "${ARGUMENTS[@]}"
do
	if grep -r -l --include "*.c" --include "*.h" $ARG . ; then
	    echo "⚡ \"${RED}$ARG${RST}\" was found in the above !"
		FINDS=$((FINDS + 1)) 
		echo ""
	fi
done

echo ""

# report 
if [ $((FINDS)) -gt 0 ]; then
	echo "⚡ ${RED}There were $FINDS matches.${RST}"
else
	echo "⚡ ${GRN}Nothing found.${RST}"
fi

# echo "⚡ ${TESTCOUNTER} Valgrind logs written as ${LOGFILE}[i]."
