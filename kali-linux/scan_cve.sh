#!/bin/bash

# [~] Scan CVE 🦈
# [~] Johnny Greeme

scan_ping() {
    local PING_COUNT=4 # [1..]
    local IPv4=$1

    echo -e "[*] ping -c $PING_COUNT $IPv4" && ping -c $PING_COUNT $IPv4
}

scan_nmap() {
    local NMAP_SPEED=4 # [0-5]
    local IPv4=$1
    local PORT=$2

    echo -e "[*] nmap -T$NMAP_SPEED -p- $IPv4" && nmap -T$NMAP_SPEED -p- $IPv4
    echo -e "[*] nmap -T$NMAP_SPEED -p$PORT -sV $IPv4" && nmap -T$NMAP_SPEED -p$PORT -sV $IPv4
    echo -e "[*] nmap -T$NMAP_SPEED -p$PORT -sV -A $IPv4" && nmap -T$NMAP_SPEED -p$PORT -sV -A $IPv4

}

scan_nuclei() {
    local IPv4=$1
    local PORT=$2
    local CVE=$3
    local TARGET="$1:$2"
    local NUCLEI_TEMPLATE=$(find /home/kali/nuclei-templates/ -iname $CVE*)

    echo -e "[*] nuclei -u $TARGET" && nuclei -u $TARGET
    echo -e "[*] nuclei -u $TARGET -as" && nuclei -u $TARGET -as
    echo -e "[*] nuclei -u $TARGET -t $NUCLEI_TEMPLATE" && nuclei -u $TARGET -t $NUCLEI_TEMPLATE
    echo -e "[*] nuclei -u $TARGET -t $NUCLEI_TEMPLATE -debug" && nuclei -u $TARGET -t $NUCLEI_TEMPLATE -debug
}

scan_cve() {
    local IPv4=$1
    local PORT=$2
    local CVE=$3
    local SOFT=$4
    local LOGIN=$5
    local PASSWORD=$6
    
    scan_ping $IPv4
    scan_nmap $IPv4 $PORT
    scan_nuclei $IPv4 $PORT $CVE
}
