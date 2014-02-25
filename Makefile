MAKE = make

PCIE_DRIVER_SUBDIR=pcie-driver
LIBBSMP_SUBDIR=libbsmp
LIBBSMP_SUBDIR_BUILD=$(LIBBSMP_SUBDIR)/build
FCS_SUBDIR=fcs
FCS_CLIENT_SUBDIR=fcs-client

.PHONY: pcie-driver libbsmp fcs fcs-client clean install uninstall

all: pcie-driver libbsmp fcs fcs-client

pcie-driver:
	$(MAKE) -C $(PCIE_DRIVER_SUBDIR)

libbsmp:
	cd $(LIBBSMP_SUBDIR) &&	mkdir build && \
	cd build && ../configure --enable-silent-rules
	$(MAKE) -C $(LIBBSMP_SUBDIR_BUILD)

fcs: pcie-driver
	cd $(FCS_SUBDIR) && ./configure
	$(MAKE) -C $(FCS_SUBDIR)

fcs-client: pcie-driver
	$(MAKE) -C $(FCS_CLIENT_SUBDIR)

install: pcie-driver libbsmp
	$(MAKE) -C $(PCIE_DRIVER_SUBDIR) install
	$(MAKE) -C $(LIBBSMP_SUBDIR) install

uninstall:
	$(MAKE) -C $(PCIE_DRIVER_SUBDIR) uninstall
	$(MAKE) -C $(LIBBSMP_SUBDIR) uninstall

clean:
	$(MAKE) -C $(PCIE_DRIVER_SUBDIR) clean
	$(MAKE) -C $(LIBBSMP_SUBDIR_BUILD) clean
	$(MAKE) -C $(FCS_SUBDIR) clean
	$(MAKE) -C $(FCS_CLIENT_SUBDIR) clean
