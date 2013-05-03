DEFAULT_BACKGROUND=desktop-background

INSTALL=install -m 0644
SVGS=$(wildcard backgrounds/*.svg gdm3/*.svg grub/*.svg)
PNGS=$(shell echo $(SVGS) | sed 's/.svg/.png/g' )
NAMES=$(shell echo $(SVGS) | sed 's/.svg//g' )

all: build

build:

	@printf "Generando imágenes desde las fuentes [SVG > PNG] ["
	@for IMAGE in $(NAMES); do \
		convert -background None $${IMAGE}.svg $${IMAGE}.png; \
		printf "."; \
	done
	@printf "]\n"

clean:

	rm -rf $(PNGS)

install:

	# background files
	mkdir -p $(DESTDIR)/usr/share/images/desktop-base
	$(INSTALL) $(wildcard backgrounds/*.png) $(DESTDIR)/usr/share/images/desktop-base
	$(INSTALL) backgrounds/default $(DESTDIR)/usr/share/images/desktop-base

	# GNOME background descriptor
	mkdir -p $(DESTDIR)/usr/share/gnome-background-properties
	$(INSTALL) gnome-backgrounds.xml $(DESTDIR)/usr/share/gnome-background-properties/debian.xml
	
	# GDM 3 theme
	mkdir -p $(DESTDIR)/usr/share/gdm/dconf
	$(INSTALL) gdm3/login-background.png $(DESTDIR)/usr/share/images/desktop-base
	$(INSTALL) gdm3/10-desktop-base-settings $(DESTDIR)/usr/share/gdm/dconf/

	# grub
	$(INSTALL) grub/canaima-grub.png $(DESTDIR)/usr/share/images/desktop-base/
	$(INSTALL) grub/grub_background.sh $(DESTDIR)/usr/share/desktop-base/
