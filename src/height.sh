#!/bin/bash -e

DEFAULT_PORT=26657

usage() {
	cat << EOF >&2

Usage: $0 [-h] [-v] <ip:port>

        -v: Show verbose curl output for debugging
 <ip:port>: Enter any number of IP addresses (optionally with a PORT specified)
            to query balance on.
        -h: Show this message

EOF
	exit 1
}

# Default to `curl --silent`:
VERBOSE_FLAG="-s"

while getopts "hv:" arg; do
	case $arg in
		v)
			VERBOSE_FLAG="-v"
			shift $() ;;

		h)
			usage ;;
		*)
			usage ;;
		esac
done

if [ -z "$1" ]
then
    echo "No argument supplied!"
	usage
fi

printf "\n\e[1;39mQuerying latest block height(s):\e[0m\n\n"
printf "    IP\t\tPORT\tHeight\n"

for arg in "$@"
do
	# Better way of getting remaining args to iterate?
	IP_ADDR="$( cut -d':' -f1 <<< "$arg" )"
	PORT="$( cut -d':' -f2 <<< "$arg" )"

	if [ $PORT == $IP_ADDR ]
	then
		PORT=$DEFAULT_PORT
	fi

	STATUS_JSON=$( curl $VERBOSE_FLAG $IP_ADDR:$PORT/status )

	HEIGHT=$( echo "$STATUS_JSON" | jq | grep "latest_block_height" | sed 's/[^0-9]*//g' )
	NETWORK=$( echo "$STATUS_JSON" | jq | grep "network" | sed 's/": "/\n/g' | sed -n '2p' | sed 's/",//g')

	printf "\n\e[0m[\e[1;32m*\e[0m] $IP_ADDR\t$PORT\t$HEIGHT\n"
	# echo "Network: $NETWORK"

	if [ $VERBOSE_FLAG == "-v" ] 
	then
		printf "\n"
	fi
done

exit 0

