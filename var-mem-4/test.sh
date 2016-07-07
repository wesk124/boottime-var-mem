#!/bin/bash

# Declare variables

COUNT_OF_CONFIGS=$1
INTER_TIME=$2
CURR_DIR=`pwd`

VAR_KERNEL="$CURR_DIR/mini-os.gz"
VAR_DESTRO="destroy"
VAR_MEMORY="30"
VAR_VCPU="1"

#if [ ! $# == "2" ]; then
#	echo "Usage: $0 <max num. of unikernels> <time between xl creates (s)>"
#	exit
#fi

#if [ ! `whoami` == "root" ]; then
#	echo "Please run as root"
#	exit
#fi

# generate the target domain config file
target=/etc/xen/target_app.cfg
echo -n "" > $target
echo "kernel=\"$VAR_KERNEL\"" >> $target
echo "memory=$VAR_MEMORY" >> $target
echo "vcpus=$VAR_VCPU" >> $target
echo "name=\"test_app$i\"" >> $target
echo "on_crash=\"$VAR_DESTRO\"" >> $target



# generating the configure files
for i in `seq 0 $COUNT_OF_CONFIGS`; do
	temp=/etc/xen/test_app$i.cfg
	echo -n "" > $temp
	echo "kernel=\"$VAR_KERNEL\"" >> $temp
	echo "memory=$VAR_MEMORY" >> $temp
	echo "vcpus=$VAR_VCPU" >> $temp
	echo "name=\"test_app$i\"" >> $temp
	echo "on_crash=\"$VAR_DESTRO\"" >> $temp
done

# Reset result file
echo -n "" > data.txt

echo $(xl create /etc/xen/target_app.cfg -q -c | grep "time is:" | cut -d " " -f 4 )>> data.txt &


