#!/bin/zsh
TESTCOUNTER=0
LEAKSCOUNT=0
EXECUTABLE="./push_swap"
LOGFILE="vlog"
ARGUMENTS=(
 	# bad arguments, should print "Error\n"
	#"1 a"				# non-number
	#"1 2 1"				# duplicate
	#"1 2 1 1 2"			# duplicate
	#"2147483648"			# over maxint
	#"-2147483649"			# under minint

	# no argument special case, should print nothing
	#""
	#" "

	# proper arguments
	#"0"
	#"2147483647"			#maxint
	#"-2147483648"			#minint
	#"576"
	#"-1 1"
	#"1 2 3"
	"10 1 -2 11"
)

# colors
GRN="\033[1;32m"
RED="\033[1;31m"
RST="\033[0m"

# Common error messages to check for
ERROR_MESSAGES=(
    "Segmentation fault"
    "Bus error"
    "Illegal instruction"
    "Floating point exception"
    "No such file or directory"
    "Permission denied"
    "command not found"
	"Invalid read"
	"Process terminating"
	"SIGSEGV"
)

# check for executable
if [ ! -f $EXECUTABLE ]; then
	echo "⚡ ${RED}Executable $EXECUTABLE not found.${RST}"
    exit 1
fi

# check -g compiler flag in (not 100% this works!)
if file $EXECUTABLE | grep -q "not stripped"; then
    echo "⚡ Executable contains debug information."
else
	echo "⚡ ${RED}Warning: Executable does not contain debug information.${RST}"
fi
echo "⚡ ${GRN}Testing begins!${RST}"
echo ""


# run tests
for ARG in "${ARGUMENTS[@]}"
do
	TESTCOUNTER=$((TESTCOUNTER + 1))
	# echo "⚡ logfile: ${LOGFILE}${TESTCOUNTER}"
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --log-file=${LOGFILE}${TESTCOUNTER} $EXECUTABLE $ARG
	
	
	if grep -q "All heap blocks were freed -- no leaks are possible" "${LOGFILE}${TESTCOUNTER}"; then
    	echo "⚡ ${GRN}Test $TESTCOUNTER: No memory leaks detected."${RST}
	else
	    echo "⚡ ${RED}Test $TESTCOUNTER: Memory leaks detected!${RST}"
		LEAKSCOUNT=$((LEAKSCOUNT + 1)) 
	fi
	echo "⚡ Args: $ARG"
	echo ""

	# Check for common error messages in the log file
	for ERROR in "${ERROR_MESSAGES[@]}"; do
		if grep -q "$ERROR" ${LOGFILE}${TESTCOUNTER}; then
			echo "✋${RED}Error detected: $ERROR check the log file ${RST}✋"
		fi
	done

done

# report 
if [ $((LEAKSCOUNT)) -gt 0 ]; then
	echo "⚡ ${RED}There were $LEAKSCOUNT leaks found in $TESTCOUNT tests${RST}"
else
	echo "⚡ ${GRN}No leaks were found.${RST}"
fi

echo "⚡ ${TESTCOUNTER} Valgrind logs written as ${LOGFILE}[i]."
