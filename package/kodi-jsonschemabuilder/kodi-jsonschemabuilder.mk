################################################################################
#
# kodi-jsonschemabuilder
#
################################################################################

# Not possible to directly refer to kodi variables, because of
# first/second expansion trickery...
HOST_KODI_JSONSCHEMABUILDER_VERSION = 17.0-Krypton
HOST_KODI_JSONSCHEMABUILDER_SOURCE = kodi-$(HOST_KODI_JSONSCHEMABUILDER_VERSION).tar.gz
HOST_KODI_JSONSCHEMABUILDER_SITE = $(call github,xbmc,xbmc,$(KODI_VERSION))
HOST_KODI_JSONSCHEMABUILDER_LICENSE = GPLv2
HOST_KODI_JSONSCHEMABUILDER_LICENSE_FILES = LICENSE.GPL
HOST_KODI_JSONSCHEMABUILDER_SUBDIR = tools/depends/native/JsonSchemaBuilder

HOST_KODI_JSONSCHEMABUILDER_CONF_OPTS += \
	-DCMAKE_MODULE_PATH=$(@D)/project/cmake/modules

HOST_KODI_JSONSCHEMABUILDER_INSTALL_CMDS = \
	$(INSTALL) -m 755 -D \
		$(@D)/tools/depends/native/JsonSchemaBuilder/JsonSchemaBuilder \
		$(HOST_DIR)/usr/bin/JsonSchemaBuilder

$(eval $(host-cmake-package))
