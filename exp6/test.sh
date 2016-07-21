#!/bin/sh

if [ $# -ne 1 ]; then 

    echo "Usage:  $0 <max num of microsec of sleep()>"
    exit
fi  

# Initializations of data files
echo -n "" > cpu-log.dat
echo -n "" > avg-stddiv.dat

for i in `seq 1 $1 `;do 
    # Prepare the to items in the xenstore we will access
    xenstore-write /test/read_access $i
    #xenstore-write /test/write_access ""

    # Give the permission to our VM which will be named "Mini-OS"
    # read for the first, and read + write for the second item
    xenstore-chmod /test/read_access rMini-OS
    #xenstore-chmod /test/write_access bMini-OS



    # Launch unikernel
    make run

    # wait 3 secs for unikernel bootting
    sleep 3

    # echo passing message
    echo "test/read_access read from dom0:"

    xenstore-read /test/read_access

    #echo "test/write_access read from dom0:"

    #xenstore-read /test/write_access

    sleep 3

    echo "microsec of usleep(): "$i >> cpu-log.dat
    xentop -b -i 11 | grep Mini | awk '{if(NR > 1) {print $4}}' >> cpu-log.dat


    # Cleanup the xenstore
    xenstore-rm /test

    echo "xenstore path test/ has been cleaned."

    xl shutdown -a

    echo "shutdown guest domain."
    echo "done" $i/$1
done

