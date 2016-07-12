#!/bin/sh

# Declare variables

COUNT_OF_CONFIGS=$1
INTER_TIME=$2
CURR_DIR=`pwd`

VAR_KERNEL="$CURR_DIR/mini-os.gz"
VAR_DESTRO="destroy"
VAR_MEMORY="30"
VAR_VCPU="1"

if [ ! $# == "2" ]; then
	echo "Usage: $0 <max num. of unikernels> <time between xl creates (s)>"
	exit
fi

if [ ! `whoami` == "root" ]; then
	echo "Please run as root"
	exit
fi

# generating the configure files
for i in `seq 0 $COUNT_OF_CONFIGS`; do
	target=/etc/xen/test_app$i.cfg
	echo -n "" > $target
	echo "kernel=\"$VAR_KERNEL\"" >> $target
	echo "memory=$VAR_MEMORY" >> $target
	echo "vcpus=$VAR_VCPU" >> $target
	echo "name=\"test_app$i\"" >> $target
	echo "on_crash=\"$VAR_DESTRO\"" >> $target
done

# Reset result file
echo -n "" > data.txt

# Main loop of the experiment
for i in `seq 0 $COUNT_OF_CONFIGS`; do
	# Write in the target appiliance boot time
	VAR_RESULT=$(chrono xl create /etc/xen/test_app$i.cfg)
	echo $i $VAR_RESULT >> data.txt 
	echo "done $i/$COUNT_OF_CONFIGS"
	sleep $2
done

# Destroy all appliances and remove all configure files

for i in `seq 0 $COUNT_OF_CONFIGS`; do 
	xl destroy test_app$i
	rm /etc/xen/test_app$i.cfg
	echo "destroyed $i/$COUNT_OF_CONFIGS"
done
