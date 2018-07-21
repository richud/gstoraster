#gs filename
CUPS_GHOSTSCRIPT = gs

CUPS_PDFTOPS_RENDERER = GS

CUPS_PDFTOPS_MAX_RESOLUTION = 0
CUPS_POPPLER_PDFTOPS =
CUPS_POPPLER_PDFTOCAIRO =
CUPS_ACROREAD =

INSTALL_PROGRAM = install -D -m 755
INSTALL_DATA = install -D

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
	-DCUPS_GHOSTSCRIPT='"$(CUPS_GHOSTSCRIPT)"' -DCUPS_PDFTOPS_RENDERER='"$(CUPS_PDFTOPS_RENDERER)"' \
	-DCUPS_PDFTOPS_MAX_RESOLUTION='"$(CUPS_PDFTOPS_MAX_RESOLUTION)"' -DCUPS_POPPLER_PDFTOPS='"$(CUPS_POPPLER_PDFTOPS)"' \
	-DCUPS_POPPLER_PDFTOCAIRO='"$(CUPS_POPPLER_PDFTOCAIRO)"' -DCUPS_ACROREAD='"$(CUPS_ACROREAD)"' \
	-o filter/pdftops \
        filter/pdftops.c \
        $(LDFLAGS) $(CPPFLAGS)

install:
	$(INSTALL_PROGRAM) filter/pdftops filter/gstopdf filter/gstoraster $(DESTDIR)$(CUPSSERVERBIN)/filter

clean:
	rm -rf filter/gstoraster filter/pdftops

