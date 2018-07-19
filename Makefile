#gs binary path on final target
GSBINDIR = /bin

#gs filename
CUPS_GHOSTSCRIPT = gs

INSTALL_PROGRAM = install -D -m 755
INSTALL_DATA = install -D

CUPSCONFIG = cups-config

CUPSDATA = $(shell $(CUPSCONFIG) --datadir)
CUPSSERVERBIN = $(shell $(CUPSCONFIG) --serverbin)
CUPSSERVERROOT = $(shell $(CUPSCONFIG) --serverroot)


all:
	$(CC) $(CFLAGS) -I./  $(CPPFLAGS) -DBINDIR='"$(GSBINDIR)"' -DCUPSDATA='"$(CUPSDATA)"' -DCUPS_GHOSTSCRIPT='"$(CUPS_GHOSTSCRIPT)"' \
	-o filter/gstoraster \
	filter/gstoraster.c \
	cupsfilters/colord.c cupsfilters/colormanager.c cupsfilters/raster.c \
	$(LDFLAGS) $(CPPFLAGS)

install:
	$(INSTALL_PROGRAM) filter/gstoraster $(DESTDIR)$(CUPSSERVERBIN)/filter

clean:
	rm -rf filter/gstoraster

