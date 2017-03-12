################################################################################
#
# kodi-skin-confluence
#
################################################################################

KODI_SKIN_CONFLUENCE_VERSION = a87bd1ddd13aff52ad58d9d3f5af91e4567e58c6
KODI_SKIN_CONFLUENCE_SITE = $(call github,xbmc,skin.confluence,$(KODI_SKIN_CONFLUENCE_VERSION))
KODI_SKIN_CONFLUENCE_LICENSE = GPLv2+
KODI_SKIN_CONFLUENCE_LICENSE_FILES = LICENSE.txt
KODI_SKIN_CONFLUENCE_DEPENDENCIES = kodi
KODI_SKIN_CONFLUENCE_CONF_OPTS = -DOVERRIDE_PATHS=1

define KODI_SKIN_CONFLUENCE_BUILD_CMDS
	$(HOST_DIR)/usr/bin/TexturePacker -input $(@D)/media/ -output $(@D)/media/Textures.xbt -dupecheck -use_none
endef

define KODI_SKIN_CONFLUENCE_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/kodi/addons/skin.confluence
	cp -dpfr $(@D)/* $(TARGET_DIR)/usr/share/kodi/addons/skin.confluence
	find $(TARGET_DIR)/usr/share/kodi/addons/skin.confluence/media -name *.jpg -delete
	find $(TARGET_DIR)/usr/share/kodi/addons/skin.confluence/media -name *.png -delete
endef

$(eval $(generic-package))
