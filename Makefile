##### reconstituted from cups-filters - rfm ######

#gs filename
CUPS_GHOSTSCRIPT = gs

#0 = gs
CUPS_PDFTOPS_RENDERER = 0

CUPS_PDFTOPS_MAX_RESOLUTION = 0
CUPS_POPPLER_PDFTOPS =
CUPS_POPPLER_PDFTOCAIRO =
CUPS_ACROREAD =

INSTALL_PROGRAM = install -D -m 755


CUPSCONFIG = cups-config

CUPSDATA = $(shell $(CUPSCONFIG) --datadir)
CUPSSERVERBIN = $(shell $(CUPSCONFIG) --serverbin)
CUPSSERVERROOT = $(shell $(CUPSCONFIG) --serverroot)

all: gstoraster pdftops

gstoraster:
	$(CC) $(CFLAGS) -I./  $(CPPFLAGS) -DCUPSDATA='"$(CUPSDATA)"' -DCUPS_GHOSTSCRIPT='"$(CUPS_GHOSTSCRIPT)"' \
	-o filter/gstoraster \
	filter/gstoraster.c \
	cupsfilters/colord.c cupsfilters/colormanager.c cupsfilters/raster.c \
	$(LDFLAGS) $(CPPFLAGS)

pdftops:
	$(CC) $(CFLAGS) -I./  $(CPPFLAGS) \
	-DHAVE_GHOSTSCRIPT_PS2WRITE \
	-DCUPS_PDFTOPS_MAX_RESOLUTION=$(CUPS_PDFTOPS_MAX_RESOLUTION) -DCUPS_PDFTOPS_RENDERER=$(CUPS_PDFTOPS_RENDERER) \
	-DCUPS_GHOSTSCRIPT='"$(CUPS_GHOSTSCRIPT)"' -DCUPS_POPPLER_PDFTOPS='"$(CUPS_POPPLER_PDFTOPS)"' \
	-DCUPS_POPPLER_PDFTOCAIRO='"$(CUPS_POPPLER_PDFTOCAIRO)"' -DCUPS_ACROREAD='"$(CUPS_ACROREAD)"' \
	-o filter/pdftops \
        filter/pdftops.c \
        $(LDFLAGS) $(CPPFLAGS)

install:
	$(INSTALL_PROGRAM) filter/pdftops filter/gstopdf filter/gstoraster $(DESTDIR)$(CUPSSERVERBIN)/filter
	$(INSTALL_PROGRAM) mime/* $(DESTDIR)$(CUPSDATA)/mime

clean:
	rm -rf filter/gstoraster filter/pdftops

