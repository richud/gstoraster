gstoraster was removed from ghostscript after 9.07 and put into cups-filters.

cups-filters as a ton of dependencies and all I needed was gstoraster in order to print with cups.

This is simply the removed files that can be compiled and used with cups and ghostscript (gstoraster is esentially a wrapper for ghostscript)

I imagine this is mostly of use to people making embedded/minimal systems and will be cross compiling.

Cross compiling it requires cups headers (cups/cups.h) and and depending on how cups is compiled, zlib and possibly others, assuming it was using shared lib.
(cups-config derives the target install paths based on how they were defined when cups was built.)

e.g.

	git clone https://github.com/richud/gstoraster
	cd gstoraster
	make CUPSCONFIG="$(cups_PATH)/cups-config" \
	LDFLAGS="-L$(zlib_PATH) -lz -L$(cups_PATH)/cups -lcups -L$(cups_PATH)/filter -lcupsimage" \
	CPPFLAGS="-I$(zlib_PATH) -I$(cups_PATH)" \
	
	make CUPSCONFIG="$(cups_PATH)/cups-config" DESTDIR=$(DESTDIR) install
	
	
Not cross compiling, and assuming you have libcups-dev etc, just

e.g.

	git clone https://github.com/richud/gstoraster
	cd gstoraster
	make
	make install
