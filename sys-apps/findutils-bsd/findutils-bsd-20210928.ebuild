# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs vcs-snapshot

DESCRIPTION="BSD utilities for finding files"
HOMEPAGE="https://www.freebsd.org"
SRC_URI="https://github.com/matijaskala/${PN}/archive/3cdb98de0cffd4c52ee71d9cee0cc70159b30c34.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="elibc_musl"
RESTRICT="mirror"

DEPEND="dev-libs/libbsd
	elibc_musl? ( sys-libs/fts-standalone )"
RDEPEND="${DEPEND}
	!sys-freebsd/freebsd-ubin
	userland_GNU? ( !sys-apps/findutils )"

src_prepare() {
	default

	tc-export CC
	use elibc_musl && export LDLIBS+=" -lfts"
}

#src_install() {
#	default
#
#	if [[ ${USERLAND} == GNU ]] ; then
#		mv "${D}"/usr/bin/find "${D}"/usr/bin/bsdfind || die
#		mv "${D}"/usr/bin/xargs "${D}"/usr/bin/bsdxargs || die
#		mv "${D}"/usr/share/man/man1/find.1 "${D}"/usr/share/man/man1/bsdfind.1 || die
#		mv "${D}"/usr/share/man/man1/xargs.1 "${D}"/usr/share/man/man1/bsdxargs.1 || die
#	fi
#}
