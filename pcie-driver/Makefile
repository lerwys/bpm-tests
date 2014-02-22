MAKE = make

PCIE_SUBDIR=pcie
DRIVERS_DIR=drivers/$(PCIE_SUBDIR)
LIB_DIR=lib/$(PCIE_SUBDIR)
TESTS_DIR=tests/$(PCIE_SUBDIR)

.PHONY: driver lib tests clean install uninstall

all: drivers lib tests

driver:
	$(MAKE) -C $(DRIVERS_DIR)

lib: driver
	$(MAKE) -C $(LIB_DIR)

tests: driver lib
	$(MAKE) -C $(TESTS_DIR)

install: driver lib
	$(MAKE) -C $(DRIVERS_DIR) install
	$(MAKE) -C $(LIB_DIR) install

uninstall: driver lib
	$(MAKE) -C $(DRIVERS_DIR) uninstall
	$(MAKE) -C $(LIB_DIR) uninstall

clean:
	$(MAKE) -C $(DRIVERS_DIR) clean
	$(MAKE) -C $(LIB_DIR) clean
	$(MAKE) -C $(TESTS_DIR) clean
