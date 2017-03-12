################################################################################
#
# kodi-texturepacker
#
################################################################################

# Not possible to directly refer to kodi variables, because of
# first/second expansion trickery...
HOST_KODI_TEXTUREPACKER_VERSION = 17.0-Krypton
HOST_KODI_TEXTUREPACKER_SOURCE = kodi-$(HOST_KODI_TEXTUREPACKER_VERSION).tar.gz
HOST_KODI_TEXTUREPACKER_SITE = $(call github,xbmc,xbmc,$(KODI_VERSION))
HOST_KODI_TEXTUREPACKER_LICENSE = GPLv2
HOST_KODI_TEXTUREPACKER_LICENSE_FILES = LICENSE.GPL
HOST_KODI_TEXTUREPACKER_SUBDIR = tools/depends/native/TexturePacker
HOST_KODI_TEXTUREPACKER_DEPENDENCIES += \
	host-giflib \
	host-libjpeg \
	host-libpng \
	host-lzo \
	xmlstarlet

HOST_KODI_TEXTUREPACKER_HOST_CXXFLAGS = "$(HOST_CXXFLAGS) -std=c++0x \
	-DTARGET_POSIX -DTARGET_LINUX -D_LINUX -I$(@D)/xbmc/linux"

HOST_KODI_TEXTUREPACKER_CONF_OPTS += \
	-DCMAKE_CXX_FLAGS=$(HOST_KODI_TEXTUREPACKER_HOST_CXXFLAGS) \
	-DCMAKE_MODULE_PATH=$(@D)/project/cmake/modules \
	-DCORE_SOURCE_DIR=$(@D) \
	-Wno-dev

HOST_KODI_TEXTUREPACKER_INSTALL_CMDS = \
	$(INSTALL) -m 755 -D \
		$(@D)/tools/depends/native/TexturePacker/TexturePacker \
		$(HOST_DIR)/usr/bin/TexturePacker

$(eval $(host-cmake-package))
