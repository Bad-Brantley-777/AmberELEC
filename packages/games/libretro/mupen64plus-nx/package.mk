# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Fewtarius

PKG_NAME="mupen64plus-nx"
PKG_VERSION="1b67122ff6a923c93a56ff94273e3768a6da5dff"
PKG_SHA256="e49f4d1b9a16cd7fa5314260c34d19c5b2d00c9c40f1414a06507759431d93a4"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mupen64plus-libretro-nx"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain nasm:host $OPENGLES"
PKG_SECTION="libretro"
PKG_SHORTDESC="mupen64plus NX"
PKG_LONGDESC="mupen64plus NX"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="-lto"

pre_configure_target() {
  sed -e "s|^GIT_VERSION ?.*$|GIT_VERSION := \" ${PKG_VERSION:0:7}\"|" -i Makefile

  if [ "${DEVICE}" = "RG552" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=RK3399 HAVE_PARALLEL_RSP=1"
  else
    PKG_MAKE_OPTS_TARGET+=" platform=RK3326 HAVE_PARALLEL_RSP=1"
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp mupen64plus_next_libretro.so $INSTALL/usr/lib/libretro/
}
