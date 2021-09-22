# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs vcs-snapshot

DESCRIPTION="FreeBSD commands to read man pages"
HOMEPAGE="https://www.freebsd.org"
SRC_URI="https://github.com/matijaskala/${PN}/archive/c461a1504459e00f716dd95e1d92468649fdde09.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="|| (
		sys-apps/groff
		app-text/mandoc[-system-man(-)]
	)
	virtual/pager
	!app-text/mandoc[system-man(-)]
	!sys-apps/man
	!sys-apps/man-db
	!sys-apps/man-netbsd
	!sys-freebsd/freebsd-ubin"

src_prepare() {
	default

	tc-export CC
}
