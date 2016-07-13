#!/bin/bash

for i in `seq 1 $1`; do
    (xl create /etc/xen/mem_test1k.cfg -q -c | grep "Desired" | cut -d " " -f 4) &
    wait
done
