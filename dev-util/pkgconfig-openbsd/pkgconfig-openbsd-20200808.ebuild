# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit perl-functions multilib-minimal vcs-clean

# cvs -d anoncvs@anoncvs.openbsd.org:/cvs get src/usr.bin/pkg-config

PKG_M4_VERSION=0.28

COMMIT_ID="f7ced61b7a64bdac2113f4bc489a873f2be32d60"
DESCRIPTION="A perl based version of pkg-config from OpenBSD"
HOMEPAGE="http://cvsweb.openbsd.org/cgi-bin/cvsweb/src/usr.bin/pkg-config/"
SRC_URI="https://github.com/matijaskala/${PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz
	pkg-config? ( https://pkgconfig.freedesktop.org/releases/pkg-config-${PKG_M4_VERSION}.tar.gz )"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+pkg-config"
RESTRICT="mirror"

RDEPEND="virtual/perl-Getopt-Long
	pkg-config? (
		!dev-util/pkgconfig
		!dev-util/pkgconf[pkg-config]
	)"

S=${WORKDIR}/${PN}-${COMMIT_ID}

src_prepare() {
	default
	ecvs_clean

	# Config.pm from dev-lang/perl doesn't set ARCH, only archname
	sed -i -e '/Config/s:ARCH:archname:' pkg-config || die

	if use pkg-config; then
		MULTILIB_CHOST_TOOLS=( /usr/bin/pkg-config )
	else
		MULTILIB_CHOST_TOOLS=( /usr/bin/pkg-config-openbsd )
	fi
}

multilib_src_install() {
	local pc_bin=pkg-config
	use pkg-config || pc_bin+=-openbsd

	newbin "${S}"/pkg-config ${pc_bin}
	newman "${S}"/pkg-config.1 ${pc_bin}.1

	# insert proper paths
	local pc_paths=(
		/usr/$(get_libdir)/pkgconfig
		/usr/share/pkgconfig
	)
	sed -i -e "/my @PKGPATH/,/;/{s@(.*@( ${pc_paths[*]} );@p;d}" \
		"${ED%/}/usr/bin/${pc_bin}" || die
}

multilib_src_install_all() {
	if use pkg-config; then
		insinto /usr/share/aclocal
		doins "${WORKDIR}"/pkg-config-*/pkg.m4
	fi

	perl_set_version
	insinto "${VENDOR_LIB}"
	doins -r "${S}"/OpenBSD
}
