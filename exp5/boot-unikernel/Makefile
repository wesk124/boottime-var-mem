XEN_SRC_DIR=/root/xen
SRC=main.c rdtsc.h
ARCH=x86_64
XEN_CONFIG=domain_config.xl

all:
	make -C $(XEN_SRC_DIR)/stubdom/c clean
	cp -rf $(SRC) $(XEN_SRC_DIR)/stubdom/c/
	make -C $(XEN_SRC_DIR)/stubdom c-stubdom
	cp -f $(XEN_SRC_DIR)/stubdom/mini-os-x86_64-c/mini-os.gz .

run: mini-os.gz
	xl create $(XEN_CONFIG) 
	
clean:
	rm -rf mini-os.gz
