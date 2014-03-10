MAKE = make

MKPATH = mkdir -p
Q = -

PCIE_DRIVER_SUBDIR=pcie-driver
LIBBSMP_SUBDIR=libbsmp
LIBBSMP_SUBDIR_BUILD=$(LIBBSMP_SUBDIR)/build
FCS_SUBDIR=fcs
FCS_DEFAULT_SERVER=fmc_config_130m_4ch_passive_pcie_server
FCS_SYM_SERVER=fcs_server
FCS_CLIENT_SUBDIR=fcs-client

.PHONY: pcie-driver libbsmp fcs fcs-client \
	pcie-driver_install libbsmp_install \
	fcs_install fcs-client_install install \
	pcie-driver_uninstall libbsmp_uninstall \
	fcs_uninstall fcs-client_uninstall uninstall \
	clean distclean

all: pcie-driver libbsmp fcs fcs-client

pcie-driver:
	$(MAKE) -C $(PCIE_DRIVER_SUBDIR)

pcie-driver_install: pcie-driver
	$(MAKE) -C $(PCIE_DRIVER_SUBDIR) install

pcie-driver_uninstall:
	$(MAKE) -C $(PCIE_DRIVER_SUBDIR) uninstall

libbsmp:
	cd $(LIBBSMP_SUBDIR) &&	$(MKPATH) build && \
	cd build && ../configure --enable-silent-rules
	$(MAKE) -C $(LIBBSMP_SUBDIR_BUILD)

libbsmp_install: libbsmp
	$(MAKE) -C $(LIBBSMP_SUBDIR_BUILD) install

libbsmp_uninstall:
	$(MAKE) -C $(LIBBSMP_SUBDIR_BUILD) uninstall

fcs: pcie-driver_install libbsmp_install
	cd $(FCS_SUBDIR) && ./configure
	$(MAKE) -C $(FCS_SUBDIR)

fcs_install:
	$(MAKE) -C $(FCS_SUBDIR) install
	ln -sf /usr/local/bin/$(FCS_DEFAULT_SERVER) \
		/usr/local/bin/$(FCS_SYM_SERVER)

fcs_uninstall:
	$(MAKE) -C $(FCS_SUBDIR) uninstall

fcs-client: libbsmp_install
	$(MAKE) -C $(FCS_CLIENT_SUBDIR)

fcs-client_install:
	$(MAKE) -C $(FCS_CLIENT_SUBDIR) install

fcs-client_uninstall:
	$(MAKE) -C $(FCS_CLIENT_SUBDIR) uninstall

install: pcie-driver_install libbsmp_install \
	fcs_install fcs-client_install

uninstall: pcie-driver_uninstall libbsmp_uninstall \
	fcs_uninstall fcs-client_uninstall

clean:
	$(Q)$(MAKE) -C $(PCIE_DRIVER_SUBDIR) clean
	$(Q)$(MAKE) -C $(LIBBSMP_SUBDIR_BUILD) clean
	$(Q)$(MAKE) -C $(FCS_SUBDIR) clean
	$(Q)$(MAKE) -C $(FCS_CLIENT_SUBDIR) clean

distclean: clean
	$(Q)$(MAKE) -C $(LIBBSMP_SUBDIR_BUILD) distclean
	$(Q)$(MAKE) -C $(FCS_SUBDIR) distclean
