#!/bin/sh

if [ $# -ne 2 ]; then 

    echo "Usage:  $0 <max num of microsec of sleep()> <num of iterations of xentop>"
    exit
fi  

# Initializations of data files

echo -n "" > avg-stddev.dat

for i in `seq 1 $1 `;do 
    # Prepare the to items in the xenstore we will access
    xenstore-write /test/read_access $i

    # Give the permission to our VM which will be named "Mini-OS"
    xenstore-chmod /test/read_access rMini-OS

    # Launch unikernel
    make run

    # wait 3 secs for unikernel bootting
    sleep 3

    # echo passing message
    echo "test/read_access read from dom0:"

    xenstore-read /test/read_access

    sleep 3

    echo -n "" > cpu-log.dat
    xentop -b -i $(($2+1)) | grep Mini | awk '{if(NR > 1) {print $4}}' >> cpu-log.dat 
    awk -v microsec=$i '{if(NR >= 1) {sum += $1; sumsq +=$1*$1}} END {print microsec "," sum/NR "," sqrt(sumsq/NR - (sum/NR)**2)}' cpu-log.dat >> avg-stddev.dat


    # Cleanup the xenstore
    xenstore-rm /test

    echo "xenstore path test/ has been cleaned."

    xl shutdown -a

    echo "shutdown guest domain."
    echo "done" $i/$1
done


   
