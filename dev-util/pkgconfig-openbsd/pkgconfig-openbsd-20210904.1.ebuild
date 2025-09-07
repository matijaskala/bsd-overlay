# Copyright 2012-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit multilib-minimal

# cvs -d anoncvs@anoncvs.openbsd.org:/cvs get src/usr.bin/pkg-config

COMMIT_ID="c97bd7982bfa4bd4440d2e0dcae49625d27526b5"
DESCRIPTION="A perl based version of pkg-config from OpenBSD"
HOMEPAGE="http://cvsweb.openbsd.org/cgi-bin/cvsweb/src/usr.bin/pkg-config/"
SRC_URI="https://github.com/matijaskala/${PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
IUSE="+native-symlinks"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

RDEPEND="virtual/perl-Getopt-Long
	!dev-util/pkgconfig
	!dev-util/pkgconf[pkg-config(+)]"

S=${WORKDIR}/${PN}-${COMMIT_ID}

MULTILIB_CHOST_TOOLS=(
	/usr/bin/pkg-config
)

multilib_src_install() {
	dobin "${S}"/pkg-config
	doman "${S}"/pkg-config.1

	# insert proper paths
	local pc_paths=(
		/usr/$(get_libdir)/pkgconfig
		/usr/share/pkgconfig
	)
	sed -i -e "/my @PKGPATH/,/;/{s@(.*@( ${pc_paths[*]} );@p;d}" \
		"${ED}"/usr/bin/pkg-config || die
}

multilib_src_install_all() {
	insinto /usr/share/aclocal
	doins pkg.m4
	if ! use native-symlinks; then
		rm "${ED}"/usr/bin/pkg-config
	fi
}
