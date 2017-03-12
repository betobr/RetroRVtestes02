################################################################################
#
# kodi-platform
#
################################################################################

KODI_PLATFORM_VERSION = c8188d82678fec6b784597db69a68e74ff4986b5
KODI_PLATFORM_SITE = $(call github,xbmc,kodi-platform,$(KODI_PLATFORM_VERSION))
KODI_PLATFORM_LICENSE = GPLv2+
KODI_PLATFORM_LICENSE_FILES = src/util/XMLUtils.h
KODI_PLATFORM_INSTALL_STAGING = YES
KODI_PLATFORM_DEPENDENCIES = libplatform kodi

$(eval $(cmake-package))
