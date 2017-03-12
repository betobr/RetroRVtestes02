################################################################################
#
# kodi-visualisation-fountain
#
################################################################################

KODI_VISUALISATION_FOUNTAIN_VERSION = faf49ac0acde558e925fa0a3eb3dbb49606278b4
KODI_VISUALISATION_FOUNTAIN_SITE = $(call github,notspiff,visualization.fountain,$(KODI_VISUALISATION_FOUNTAIN_VERSION))
KODI_VISUALISATION_FOUNTAIN_DEPENDENCIES = kodi libsoil

$(eval $(cmake-package))
