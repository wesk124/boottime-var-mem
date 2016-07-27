SRC=main.c

include ../../Config.mk

all:
	make -C $(XEN_SRC_DIR)/stubdom/c clean
	cp -rf $(SRC) $(XEN_SRC_DIR)/stubdom/c/
	make -C $(XEN_SRC_DIR)/stubdom c-stubdom
	cp -f $(XEN_SRC_DIR)/stubdom/mini-os-x86_64-c/mini-os.gz .

clean:
	rm -rf mini-os.gz
