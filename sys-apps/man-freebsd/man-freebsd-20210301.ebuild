# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="FreeBSD commands to read man pages"
HOMEPAGE="https://www.freebsd.org"
COMMIT_ID="6a903ccdc937c9e6cde5740d1ab8d44bfbf8ad55"
SRC_URI="https://github.com/matijaskala/${PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"

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

S=${WORKDIR}/${PN}-${COMMIT_ID}

src_prepare() {
	default

	tc-export CC
}
