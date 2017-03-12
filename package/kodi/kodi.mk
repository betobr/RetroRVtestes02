################################################################################
#
# kodi
#
################################################################################

# When updating the version, please also update kodi-jsonschemabuilder
# and kodi-texturepacker
KODI_VERSION = e0a6f4cd9a452b3063d0a0afe85672cdb5b2abcc
KODI_SITE = $(call github,xbmc,xbmc,$(KODI_VERSION))
KODI_LICENSE = GPLv2
KODI_LICENSE_FILES = LICENSE.GPL
# needed for binary addons
KODI_INSTALL_STAGING = YES
KODI_DEPENDENCIES = \
	bzip2 \
	expat \
	ffmpeg \
	fontconfig \
	freetype \
	gmp \
	host-gawk \
	host-gettext \
	host-gperf \
	host-kodi-jsonschemabuilder \
	host-kodi-texturepacker \
	host-nasm \
	host-swig \
	host-xmlstarlet \
	host-zip \
	libass \
	libcdio \
	libcrossguid \
	libcurl \
	libdvdnav \
	libfribidi \
	libgcrypt \
	libplist \
	libsamplerate \
	lzo \
	ncurses \
	openssl \
	pcre \
	python \
	readline \
	sqlite \
	taglib \
	tinyxml \
	yajl \
	zlib

KODI_SUBDIR = project/cmake

KODI_CONF_OPTS += \
	-DENABLE_CCACHE=OFF \
	-DENABLE_DVDCSS=ON \
	-DENABLE_INTERNAL_CROSSGUID=OFF \
	-DENABLE_INTERNAL_FFMPEG=OFF \
	-DKODI_DEPENDSBUILD=ON \
	-DENABLE_OPENSSL=ON \
	-DNATIVEPREFIX=$(HOST_DIR)/usr \
	-DDEPENDS_PATH=$(@D) \
	-DWITH_TEXTUREPACKER=$(HOST_DIR)/usr/bin/TexturePacker

ifeq ($(BR2_aarch64),y)
KODI_CONF_OPTS += -DWITH_ARCH=aarch64 -DWITH_CPU=aarch64
else ifeq ($(BR2_arm)$(BR2_armeb),y)
KODI_CONF_OPTS += -DWITH_ARCH=arm -DWITH_CPU=arm
else ifeq ($(BR2_x86_64),y)
KODI_CONF_OPTS += -DWITH_ARCH=x86_64-linux -DWITH_CPU=x86_64
endif

ifeq ($(BR2_X86_CPU_HAS_SSE),y)
KODI_CONF_OPTS += -D_SSE_OK=ON -D_SSE_TRUE=ON
else
KODI_CONF_OPTS += -D_SSE_OK=OFF -D_SSE_TRUE=OFF
endif

ifeq ($(BR2_X86_CPU_HAS_SSE2),y)
KODI_CONF_OPTS += -D_SSE2_OK=ON -D_SSE2_TRUE=ON
else
KODI_CONF_OPTS += -D_SSE2_OK=OFF -D_SSE2_TRUE=OFF
endif

ifeq ($(BR2_X86_CPU_HAS_SSE3),y)
KODI_CONF_OPTS += -D_SSE3_OK=ON -D_SSE3_TRUE=ON
else
KODI_CONF_OPTS += -D_SSE3_OK=OFF -D_SSE3_TRUE=OFF
endif

ifeq ($(BR2_X86_CPU_HAS_SSSE3),y)
KODI_CONF_OPTS += -D_SSSE3_OK=ON -D_SSSE3_TRUE=ON
else
KODI_CONF_OPTS += -D_SSSE3_OK=OFF -D_SSSE3_TRUE=OFF
endif

ifeq ($(BR2_X86_CPU_HAS_SSE4),y)
KODI_CONF_OPTS += -D_SSE41_OK=ON -D_SSE41_TRUE=ON
else
KODI_CONF_OPTS += -D_SSE41_OK=OFF -D_SSE41_TRUE=OFF
endif

ifeq ($(BR2_X86_CPU_HAS_SSE42),y)
KODI_CONF_OPTS += -D_SSE42_OK=ON -D_SSE42_TRUE=ON
else
KODI_CONF_OPTS += -D_SSE42_OK=OFF -D_SSE42_TRUE=OFF
endif

ifeq ($(BR2_X86_CPU_HAS_AVX),y)
KODI_CONF_OPTS += -D_AVX_OK=ON -D_AVX_TRUE=ON
else
KODI_CONF_OPTS += -D_AVX_OK=OFF -D_AVX_TRUE=OFF
endif

ifeq ($(BR2_X86_CPU_HAS_AVX2),y)
KODI_CONF_OPTS += -D_AVX2_OK=ON -D_AVX2_TRUE=ON
else
KODI_CONF_OPTS += -D_AVX2_OK=OFF -D_AVX2_TRUE=OFF
endif

ifeq ($(BR2_PACKAGE_KODI_MYSQL),y)
KODI_CONF_OPTS += -DENABLE_MYSQLCLIENT=ON
KODI_DEPENDENCIES += mysql
else
KODI_CONF_OPTS += -DENABLE_MYSQLCLIENT=OFF
endif

ifeq ($(BR2_PACKAGE_KODI_NONFREE),y)
KODI_CONF_OPTS += -DENABLE_NONFREE=ON
KODI_LICENSE := $(KODI_LICENSE), unrar
KODI_LICENSE_FILES += lib/UnrarXLib/license.txt
else
KODI_CONF_OPTS += -DENABLE_NONFREE=OFF
endif

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
KODI_CONF_OPTS += -DCORE_SYSTEM_NAME=rbpi
KODI_DEPENDENCIES += rpi-userland
else
# these options only exist on non-rbpi systems
KODI_CONF_OPTS += -DENABLE_LDGOLD=OFF
ifeq ($(BR2_PACKAGE_LIBAMCODEC),y)
KODI_CONF_OPTS += -DENABLE_AML=ON
KODI_DEPENDENCIES += libamcodec
else
KODI_CONF_OPTS += -DENABLE_AML=OFF
endif
ifeq ($(BR2_PACKAGE_IMX_VPUWRAP),y)
KODI_CONF_OPTS += -DENABLE_IMX=ON
KODI_DEPENDENCIES += imx-vpuwrap
else
KODI_CONF_OPTS += -DENABLE_IMX=OFF
endif
endif

ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
KODI_CONF_OPTS += -DENABLE_UDEV=ON
KODI_DEPENDENCIES += udev
else
KODI_CONF_OPTS += -DENABLE_UDEV=OFF
endif

ifeq ($(BR2_PACKAGE_LIBCAP),y)
KODI_CONF_OPTS += -DENABLE_CAP=ON
KODI_DEPENDENCIES += libcap
else
KODI_CONF_OPTS += -DENABLE_CAP=OFF
endif

ifeq ($(BR2_PACKAGE_LIBXSLT),y)
KODI_CONF_OPTS += -DENABLE_XSLT=ON
KODI_DEPENDENCIES += libxslt
else
KODI_CONF_OPTS += -DENABLE_XSLT=OFF
endif

ifeq ($(BR2_PACKAGE_KODI_BLUEZ),y)
KODI_CONF_OPTS += -DENABLE_BLUETOOTH=ON
KODI_DEPENDENCIES += bluez5_utils
else
KODI_CONF_OPTS += -DENABLE_BLUETOOTH=OFF
endif

ifeq ($(BR2_PACKAGE_CWIID)$(BR2_PACKAGE_KODI_BLUEZ)$(BR2_PACKAGE_KODI_EVENTCLIENTS),yyy)
KODI_DEPENDENCIES += cwiid
endif

ifeq ($(BR2_PACKAGE_KODI_DBUS),y)
KODI_DEPENDENCIES += dbus
KODI_CONF_OPTS += -DENABLE_DBUS=ON
else
KODI_CONF_OPTS += -DENABLE_DBUS=OFF
endif

ifeq ($(BR2_PACKAGE_KODI_EVENTCLIENTS),y)
KODI_CONF_OPTS += -DENABLE_EVENTCLIENTS=ON
else
KODI_CONF_OPTS += -DENABLE_EVENTCLIENTS=OFF
endif

ifeq ($(BR2_PACKAGE_KODI_ALSA_LIB),y)
KODI_CONF_OPTS += -DENABLE_ALSA=ON
KODI_DEPENDENCIES += alsa-lib
else
KODI_CONF_OPTS += -DENABLE_ALSA=OFF
endif

# quote from kodi/configure.in: "GLES overwrites GL if both set to yes."
# we choose the opposite because opengl offers more features, like libva support
# GL means X11, and under X11, Kodi needs libdrm; libdrm is forcefully selected
# by a modular Xorg server, which Kodi already depends on.
ifeq ($(BR2_PACKAGE_KODI_GL_EGL),y)
KODI_DEPENDENCIES += libegl libglu libgl xlib_libX11 xlib_libXext \
	xlib_libXrandr libdrm
KODI_CONF_OPTS += -DENABLE_OPENGL=ON -DENABLE_X11=ON -DENABLE_OPENGLES=OFF
else
KODI_CONF_OPTS += -DENABLE_OPENGL=OFF -DENABLE_X11=OFF
ifeq ($(BR2_PACKAGE_KODI_EGL_GLES),y)
KODI_DEPENDENCIES += libegl libgles
KODI_CONF_ENV += CXXFLAGS="$(TARGET_CXXFLAGS) `$(PKG_CONFIG_HOST_BINARY) --cflags --libs egl`"
KODI_CONF_ENV += CFLAGS="$(TARGET_CFLAGS) `$(PKG_CONFIG_HOST_BINARY) --cflags --libs egl`"
KODI_CONF_OPTS += -DENABLE_OPENGLES=ON
else
KODI_CONF_OPTS += -DENABLE_OPENGLES=OFF
endif
endif

ifeq ($(BR2_PACKAGE_KODI_LIBUSB),y)
KODI_DEPENDENCIES += libusb-compat
endif

ifeq ($(BR2_PACKAGE_KODI_LIBMICROHTTPD),y)
KODI_CONF_OPTS += -DENABLE_MICROHTTPD=ON
KODI_DEPENDENCIES += libmicrohttpd
else
KODI_CONF_OPTS += -DENABLE_MICROHTTPD=OFF
endif

ifeq ($(BR2_PACKAGE_KODI_LIBSMBCLIENT),y)
KODI_DEPENDENCIES += samba4
KODI_CONF_OPTS += -DENABLE_SMBCLIENT=ON
else
KODI_CONF_OPTS += -DENABLE_SMBCLIENT=OFF
endif

ifeq ($(BR2_PACKAGE_KODI_LIBNFS),y)
KODI_DEPENDENCIES += libnfs
KODI_CONF_OPTS += -DENABLE_NFS=ON
else
KODI_CONF_OPTS += -DENABLE_NFS=OFF
endif

ifeq ($(BR2_PACKAGE_KODI_LIBBLURAY),y)
KODI_DEPENDENCIES += libbluray
KODI_CONF_OPTS += -DENABLE_BLURAY=ON
else
KODI_CONF_OPTS += -DENABLE_BLURAY=OFF
endif

ifeq ($(BR2_PACKAGE_KODI_LIBSHAIRPLAY),y)
KODI_DEPENDENCIES += libshairplay
KODI_CONF_OPTS += -DENABLE_AIRTUNES=ON
else
KODI_CONF_OPTS += -DENABLE_AIRTUNES=OFF
endif

ifeq ($(BR2_PACKAGE_KODI_LIBSSH),y)
KODI_DEPENDENCIES += libssh
KODI_CONF_OPTS += -DENABLE_SSH=ON
else
KODI_CONF_OPTS += -DENABLE_SSH=OFF
endif

ifeq ($(BR2_PACKAGE_KODI_AVAHI),y)
KODI_DEPENDENCIES += avahi
KODI_CONF_OPTS += -DENABLE_AVAHI=ON
else
KODI_CONF_OPTS += -DENABLE_AVAHI=OFF
endif

ifeq ($(BR2_PACKAGE_KODI_LIBCEC),y)
KODI_DEPENDENCIES += libcec
KODI_CONF_OPTS += -DENABLE_CEC=ON
else
KODI_CONF_OPTS += -DENABLE_CEC=OFF
endif

ifeq ($(BR2_PACKAGE_KODI_LIRC),y)
KODI_CONF_OPTS += -DENABLE_LIRC=ON
else
KODI_CONF_OPTS += -DENABLE_LIRC=OFF
endif

ifeq ($(BR2_PACKAGE_KODI_LIBTHEORA),y)
KODI_DEPENDENCIES += libtheora
endif

# kodi needs libva & libva-glx
ifeq ($(BR2_PACKAGE_KODI_LIBVA)$(BR2_PACKAGE_MESA3D_DRI_DRIVER),yy)
KODI_DEPENDENCIES += mesa3d libva
KODI_CONF_OPTS += -DENABLE_VAAPI=ON
else
KODI_CONF_OPTS += -DENABLE_VAAPI=OFF
endif

ifeq ($(BR2_PACKAGE_KODI_LIBVDPAU),y)
KODI_DEPENDENCIES += libvdpau
KODI_CONF_OPTS += -DENABLE_VDPAU=ON
else
KODI_CONF_OPTS += -DENABLE_VDPAU=OFF
endif

ifeq ($(BR2_PACKAGE_KODI_UPNP),y)
KODI_CONF_OPTS += -DENABLE_UPNP=ON
else
KODI_CONF_OPTS += -DENABLE_UPNP=OFF
endif

ifeq ($(BR2_PACKAGE_KODI_OPTICALDRIVE),y)
KODI_CONF_OPTS += -DENABLE_OPTICAL=ON
else
KODI_CONF_OPTS += -DENABLE_OPTICAL=OFF
endif

ifeq ($(BR2_PACKAGE_KODI_PULSEAUDIO),y)
KODI_CONF_OPTS += -DENABLE_PULSEAUDIO=ON
KODI_DEPENDENCIES += pulseaudio
else
KODI_CONF_OPTS += -DENABLE_PULSEAUDIO=OFF
endif

# Remove versioncheck addon, updating Kodi is done by building a new
# buildroot image.
KODI_ADDON_MANIFEST = $(TARGET_DIR)/usr/share/kodi/system/addon-manifest.xml
define KODI_CLEAN_UNUSED_ADDONS
	rm -Rf $(TARGET_DIR)/usr/share/kodi/addons/service.xbmc.versioncheck
	$(HOST_DIR)/usr/bin/xml ed -L \
		-d "/addons/addon[text()='service.xbmc.versioncheck']" \
		$(KODI_ADDON_MANIFEST)
endef
KODI_POST_INSTALL_TARGET_HOOKS += KODI_CLEAN_UNUSED_ADDONS

# Skins estuary and estouchy are installed by default and need to be
# removed if they are disabled in buildroot
ifeq ($(BR2_PACKAGE_KODI_SKIN_ESTUARY),y)
define KODI_CLEAN_SKIN_ESTUARY
	find $(TARGET_DIR)/usr/share/kodi/addons/skin.estuary/media -name *.gif -delete
	find $(TARGET_DIR)/usr/share/kodi/addons/skin.estuary/media -name *.jpg -delete
	find $(TARGET_DIR)/usr/share/kodi/addons/skin.estuary/media -name *.png -delete
endef
KODI_POST_INSTALL_TARGET_HOOKS += KODI_CLEAN_SKIN_ESTUARY
else
define KODI_REMOVE_SKIN_ESTUARY
	rm -Rf $(TARGET_DIR)/usr/share/kodi/addons/skin.estuary
	$(HOST_DIR)/usr/bin/xml ed -L \
		-d "/addons/addon[text()='skin.estuary']" \
		$(KODI_ADDON_MANIFEST)
endef
KODI_POST_INSTALL_TARGET_HOOKS += KODI_REMOVE_SKIN_ESTUARY
endif

ifeq ($(BR2_PACKAGE_KODI_SKIN_ESTOUCHY),y)
define KODI_CLEAN_SKIN_ESTOUCHY
	find $(TARGET_DIR)/usr/share/kodi/addons/skin.estouchy/media -name *.gif -delete
	find $(TARGET_DIR)/usr/share/kodi/addons/skin.estouchy/media -name *.jpg -delete
	find $(TARGET_DIR)/usr/share/kodi/addons/skin.estouchy/media -name *.png -delete
endef
KODI_POST_INSTALL_TARGET_HOOKS += KODI_CLEAN_SKIN_ESTOUCHY
else
define KODI_REMOVE_SKIN_ESTOUCHY
	rm -Rf $(TARGET_DIR)/usr/share/kodi/addons/skin.estouchy
	$(HOST_DIR)/usr/bin/xml ed -L \
		-d "/addons/addon[text()='skin.estouchy']" \
		$(KODI_ADDON_MANIFEST)
endef
KODI_POST_INSTALL_TARGET_HOOKS += KODI_REMOVE_SKIN_ESTOUCHY
endif

# The default value 'skin.estuary' is stored in
# xbmc/system/settings/settings.xml.
# If skin estuary is disabled this value needs to be changed to avoid
# https://github.com/xbmc/xbmc/blob/32a6916059a0b14ab5fc65cedb17b2615c039918/xbmc/Application.cpp#L1124

define KODI_SET_DEFAULT_SKIN_ESTOUCHY
	$(SED) 's/skin.estuary/skin.estouchy/#g' $(TARGET_DIR)/usr/share/kodi/system/settings/settings.xml
endef

define KODI_SET_DEFAULT_SKIN_CONFLUENCE
	$(SED) 's/skin.estuary/skin.confluence/#g' $(TARGET_DIR)/usr/share/kodi/system/settings/settings.xml
	$(HOST_DIR)/usr/bin/xml ed -L -O --subnode "/addons" \
		-t elem -n "addon" -v "skin.confluence" \
		$(KODI_ADDON_MANIFEST)
endef

ifeq ($(BR2_PACKAGE_KODI_SKIN_DEFAULT_ESTOUCHY),y)
KODI_POST_INSTALL_TARGET_HOOKS += KODI_SET_DEFAULT_SKIN_ESTOUCHY
else ifeq ($(BR2_PACKAGE_KODI_SKIN_DEFAULT_CONFLUENCE),y)
KODI_POST_INSTALL_TARGET_HOOKS += KODI_SET_DEFAULT_SKIN_CONFLUENCE
endif

define KODI_INSTALL_BR_WRAPPER
	$(INSTALL) -D -m 0755 package/kodi/br-kodi \
		$(TARGET_DIR)/usr/bin/br-kodi
endef
KODI_POST_INSTALL_TARGET_HOOKS += KODI_INSTALL_BR_WRAPPER

# When run from a startup script, Kodi has no $HOME where to store its
# configuration, so ends up storing it in /.kodi  (yes, at the root of
# the rootfs). This is a problem for read-only filesystems. But we can't
# easily change that, so create /.kodi as a symlink where we want the
# config to eventually be. Add synlinks for the legacy XBMC name as well
define KODI_INSTALL_CONFIG_DIR
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/var/kodi
	ln -sf /var/kodi $(TARGET_DIR)/.kodi
	ln -sf /var/kodi $(TARGET_DIR)/var/xbmc
	ln -sf /var/kodi $(TARGET_DIR)/.xbmc
endef
KODI_POST_INSTALL_TARGET_HOOKS += KODI_INSTALL_CONFIG_DIR

define KODI_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 755 package/kodi/S50kodi \
		$(TARGET_DIR)/etc/init.d/S50kodi
endef

define KODI_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 package/kodi/kodi.service \
		$(TARGET_DIR)/usr/lib/systemd/system/kodi.service

	mkdir -p $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants

	ln -fs ../../../../usr/lib/systemd/system/kodi.service \
		$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/kodi.service
endef

$(eval $(cmake-package))
