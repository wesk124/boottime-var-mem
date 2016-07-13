#!/bin/sh


# This linux shell script is for testing the unikernel
# boot time in different memory configurations.


# Declare variables

CURR_DIR=`pwd`

VAR_KERNEL="$CURR_DIR/mini-os.gz" 
VAR_DESTRO="destroy"
VAR_MEMORY_BASE="2"
VAR_MEMORY_EXP=$1
VAR_VCPU="1"
VAR_CURR_MEM="0"

if [ ! $# == "1" ]; then
	echo "Usage: $0 <factor of memory base>"
	exit
fi

if [ ! `whoami` == "root" ]; then
	echo "Please run as root"
	exit
fi

VAR_CURR_MEM=$((VAR_MEMORY_BASE ** VAR_MEMORY_EXP ))


for i in `seq 3 $VAR_MEMORY_EXP`; do

	#create configure files

	target=/etc/xen/mem_test.cfg
	echo -n "" > $target
	echo "kernel=\"$VAR_KERNEL\"" >> $target
	echo "memory=$((VAR_MEMORY_BASE ** i ))" >> $target
	echo "vcpus=$VAR_VCPU" >> $target
	echo "name=\"mem_test\"" >> $target
	echo "on_crash=\"$VAR_DESTRO\"" >> $target

	echo $((VAR_MEMORY_BASE ** i )) $(chrono xl create /etc/xen/mem_test.cfg) >> result.dat
	xl destroy mem_test

done

