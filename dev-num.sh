#!/bin/bash

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    echo "This Tool For Discovering How Many Devices Are on Your Network and Their IPs."
    echo "To run it, use '--run' or '-r'"
fi

if [ "$1" == "--run" ] || [ "$1" == "-r" ]; then
    mainIp=$(ifconfig ens33 | grep -i netmask | cut -d "n" -f2 | cut -d " " -f2 | cut -d"." -f 1,2,3)
    arrayIp=()
    octet=1

    echo "Running...."

    while [ $octet -lt 255 ]; do
        myDeviceIp=$(ping -c 1 "$mainIp.$octet" | grep -i ttl | cut -d " " -f 4 | cut -d ":" -f1)
        if [ -n "$myDeviceIp" ]; then
            arrayIp+=("$myDeviceIp")
        fi
        octet=$((octet + 1))
    done

    echo "Discovered devices: ${arrayIp[@]}"
fi