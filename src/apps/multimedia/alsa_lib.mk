# Copyright 2021-2024 NXP
#
# SPDX-License-Identifier: BSD-3-Clause


# alsa-lib is a library to interface with ALSA (Advanced Linux Sound Architecture)
# in the Linux kernel and virtual devices using a plugin system.


alsa_lib:
	@[ $(SOCFAMILY) != IMX -a $${MACHINE:0:7} != ls1028a -o \
	   $(DISTROVARIANT) = base -o $(DISTROVARIANT) = tiny ] && exit || \
	 $(call fbprint_b,"alsa_lib") && \
	 $(call repo-mngr,fetch,alsa_lib,apps/multimedia) && \
	 cd $(MMDIR)/alsa_lib && \
	 sed -i 's|=Versions|=$(srcdir)/Versions|g' src/topology/Makefile.am && \
	 export LD_LIBRARY_PATH=$(DESTDIR)/usr/lib:$(RFSDIR)/usr/lib:$(RFSDIR)/usr/lib/aarch64-linux-gnu && \
	 export PKG_CONFIG_PATH=$(DESTDIR)/usr/lib/pkgconfig:$(RFSDIR)/usr/lib/pkgconfig && \
	 libtoolize --force --copy --automake && aclocal && \
	 autoheader && automake --foreign --copy --add-missing && autoconf && \
	 ./configure --host=aarch64 CC=aarch64-linux-gnu-gcc 1>/dev/null && \
	 $(MAKE) -j$(JOBS) install && \
	 $(call fbprint_d,"alsa_lib")
