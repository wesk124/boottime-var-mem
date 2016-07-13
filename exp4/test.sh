#/bin/sh

# Declare varibales of running unikernel's configs

COUNT_OF_RUNNING_UNIKERNELS=$1
CURR_DIR=`pwd`

VAR_RUNNING_KERNEL="$CURR_DIR/running-unikernel/mini-os.gz"
VAR_RUNNING_DESTRO="destroy"
VAR_RUNNING_MEMORY="16"
VAR_RUNNING_VCPU="1"


# Declare varibales of boot unikernel's configs

VAR_BOOT_KERNEL="$CURR_DIR/boot-unikernel/mini-os.gz"
VAR_BOOT_DESTRO="destroy"
VAR_BOOT_MEMORY="16"
VAR_BOOT_VCPU="1"


# check num of cml var
if [ ! $# == "1" ]; then
	echo "Usage: $0 <max num. of unikernels>"
	exit
fi

# check permission
if [ ! `whoami` == "root" ]; then
	echo "Please run as root"
	exit
fi


# generate boot unikernel configs
target0=/etc/xen/boot_app.cfg
echo -n "" > $target0
echo "kernel=\"$VAR_BOOT_KERNEL\"" >> $target0
echo "memory=$VAR_BOOT_MEMORY" >> $target0
echo "vcpus=$VAR_BOOT_VCPU" >> $target0
echo "name=\"boot_app\"" >> $target0
echo "on_crash=\"$VAR_BOOT_DESTRO\"" >> $target0

# Reset data file

echo -n "" > data.txt

echo  "0" $(xl create /etc/xen/boot_app.cfg -c -q | grep "time is:" | cut -d " " -f 4) >> data.txt

wait

echo done 0 / $COUNT_OF_RUNNING_UNIKERNELS

# generate running unikernel configs
for i in `seq 1 $COUNT_OF_RUNNING_UNIKERNELS`; do
	target=/etc/xen/running_app$i.cfg
	echo -n "" > $target
	echo "kernel=\"$VAR_RUNNING_KERNEL\"" >> $target
	echo "memory=$VAR_RUNNING_MEMORY" >> $target
	echo "vcpus=$VAR_RUNNING_VCPU" >> $target
	echo "name=\"running_app$i\"" >> $target
	echo "on_crash=\"$VAR_RUNNING_DESTRO\"" >> $target
done

for i in `seq 1 $COUNT_OF_RUNNING_UNIKERNELS`; do
    xl create /etc/xen/running_app$i.cfg -q&
    wait
    echo $((i)) $(xl create /etc/xen/boot_app.cfg -c -q | grep "time is:" | cut -d " " -f 4) >> data.txt

    echo done $((i)) / $COUNT_OF_RUNNING_UNIKERNELS     
done
wait

xl shutdown -a





