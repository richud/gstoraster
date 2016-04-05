#
#
# CUPS driver makefile for Ghostscript.
#
# Copyright 2001-2005 by Easy Software Products.
# Copyright 2007 Artifex Software, Inc.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
#



### ----------------- CUPS Ghostscript Driver ---------------------- ###




#gs binary path on final target
GSBINDIR = /bin

INSTALL_PROGRAM = install -D -m 755
INSTALL_DATA = install -D

CUPSCONFIG = cups-config

CUPSDATA = $(shell $(CUPSCONFIG) --datadir)
CUPSSERVERBIN = $(shell $(CUPSCONFIG) --serverbin)
CUPSSERVERROOT = $(shell $(CUPSCONFIG) --serverroot)


all: 
	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) -DBINDIR='"$(GSBINDIR)"' -DCUPSDATA='"$(CUPSDATA)"' -o cups/gstoraster cups/gstoraster.c cups/colord.c

install: 
	$(INSTALL_PROGRAM) cups/gstopxl cups/gstoraster $(DESTDIR)$(CUPSSERVERBIN)/filter
	$(INSTALL_DATA) cups/gstoraster.convs $(DESTDIR)$(CUPSSERVERROOT)
	$(INSTALL_DATA) cups/pxlcolor.ppd cups/pxlmono.ppd $(DESTDIR)$(CUPSDATA)/model

clean:
	rm -rf cups/gstoraster
#
#
