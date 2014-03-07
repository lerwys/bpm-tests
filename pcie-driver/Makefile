MAKE = make

PCIE_SUBDIR=pcie
DRIVERS_DIR=drivers/$(PCIE_SUBDIR)
LIB_DIR=lib/$(PCIE_SUBDIR)
TESTS_DIR=tests/$(PCIE_SUBDIR)

.PHONY: driver lib tests clean driver_install \
	lib_install install driver_uninstall \
	lib_uninstall uninstall

all: driver lib tests

driver:
	$(MAKE) -C $(DRIVERS_DIR)

driver_install: driver
	$(MAKE) -C $(DRIVERS_DIR) install

driver_uninstall:
	$(MAKE) -C $(DRIVERS_DIR) uninstall

lib: driver_install
	$(MAKE) -C $(LIB_DIR)

lib_install: lib
	$(MAKE) -C $(LIB_DIR) install

lib_uninstall:
	$(MAKE) -C $(LIB_DIR) uninstall

tests: driver_install lib_install
	$(MAKE) -C $(TESTS_DIR)

install: driver_install lib_install

uninstall: driver_uninstall lib_uninstall

clean:
	$(MAKE) -C $(DRIVERS_DIR) clean
	$(MAKE) -C $(LIB_DIR) clean
	$(MAKE) -C $(TESTS_DIR) clean
