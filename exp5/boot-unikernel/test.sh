#!/bin/sh

# Prepare the to items in the xenstore we will access
xenstore-write /test/read_access "data to read"
xenstore-write /test/write_access ""

# Give the permission to our VM which will be named "Mini-OS"
# read for the first, and read + write for the second item
xenstore-chmod /test/read_access rMini-OS
xenstore-chmod /test/write_access bMini-OS

# Launch unikernel
make run

echo "test/read_access read from dom0:"

xenstore-read /test/read_access

echo "test/write_access read from dom0:"

xenstore-read /test/write_access


# Cleanup the xenstore
xenstore-rm /test
