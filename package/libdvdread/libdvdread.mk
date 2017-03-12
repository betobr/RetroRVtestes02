################################################################################
#
# libdvdread
#
################################################################################

LIBDVDREAD_VERSION = 5.0.3
LIBDVDREAD_SOURCE = libdvdread-$(LIBDVDREAD_VERSION).tar.bz2
LIBDVDREAD_SITE = http://www.videolan.org/pub/videolan/libdvdread/$(LIBDVDREAD_VERSION)
LIBDVDREAD_INSTALL_STAGING = YES
LIBDVDREAD_LICENSE = GPLv2+
LIBDVDREAD_LICENSE_FILES = COPYING
LIBDVDREAD_CONF_OPTS = --with-libdvdcss
LIBDVDREAD_DEPENDENCIES = libdvdcss host-pkgconf

# enable Kodi-specific code
ifeq ($(BR2_PACKAGE_KODI),y)
LIBDVDREAD_CONF_ENV = CFLAGS="$(TARGET_CFLAGS) -D_XBMC"
endif

$(eval $(autotools-package))
