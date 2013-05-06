# Makefile

SHELL := sh -e
DEFAULT_BACKGROUND=desktop-background
INSTALL=install -m 0644
SVGS=$(wildcard backgrounds/*.svg gdm3/*.svg grub/*.svg plymouth/*.svg)
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
	@echo "Procesando animación de Blender ..."
	@blender -b plymouth/Gnamon/progress.blend -o //D -s 00 -e 40 -a

clean:

	@rm -rf $(PNGS)
	@rm -rf plymouth/Gnamon/D00*.png
	@rm -rf plymouth/Gnamon/logo*.png
	@rm -rf plymouth/Gnamon/fondo.png

install:

	# background files
	@mkdir -p $(DESTDIR)/usr/share/images/desktop-base
	@$(INSTALL) $(wildcard backgrounds/*.png) $(DESTDIR)/usr/share/images/desktop-base
	@$(INSTALL) backgrounds/canaima.xml $(DESTDIR)/usr/share/images/desktop-base
	@cd $(DESTDIR)/usr/share/images/desktop-base && ln -s $(DEFAULT_BACKGROUND) default

	# GNOME background descriptor
	@mkdir -p $(DESTDIR)/usr/share/gnome-background-properties
	@$(INSTALL) gnome-backgrounds.xml $(DESTDIR)/usr/share/gnome-background-properties/debian.xml
	
	# GDM 3 theme
	@mkdir -p $(DESTDIR)/usr/share/gdm/dconf
	@$(INSTALL) gdm3/login-background.png $(DESTDIR)/usr/share/images/desktop-base
	@$(INSTALL) gdm3/99-desktop-base-settings $(DESTDIR)/usr/share/gdm/dconf

	# grub
	@$(INSTALL) grub/grub.png $(DESTDIR)/usr/share/images/desktop-base
	@$(INSTALL) grub/grub_background.sh $(DESTDIR)/usr/share/desktop-base

	# plymouth
	@mkdir -p $(DESTDIR)/usr/share/plymouth/themes/Gnamon
	@$(INSTALL) plymouth/Gnamon/*.png $(DESTDIR)/usr/share/plymouth/themes/Gnamon
	@$(INSTALL) plymouth/Gnamon/Gnamon.plymouth $(DESTDIR)/usr/share/plymouth/themes/Gnamon
	@$(INSTALL) plymouth/Gnamon/Gnamon.script $(DESTDIR)/usr/share/plymouth/themes/Gnamon
