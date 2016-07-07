XEN_SRC_DIR=/root/xen
SRC=main.c
ARCH=x86_64
XEN_CONFIG=/etc/xen/mem_test1k.cfg

all:
	make -C $(XEN_SRC_DIR)/stubdom/c clean
	cp -rf $(SRC) $(XEN_SRC_DIR)/stubdom/c/
	make -C $(XEN_SRC_DIR)/stubdom c-stubdom
	cp -f $(XEN_SRC_DIR)/stubdom/mini-os-x86_64-c/mini-os.gz .

run: mini-os.gz
	xl create $(XEN_CONFIG) -c
	
clean:
	rm -rf mini-os.gz
