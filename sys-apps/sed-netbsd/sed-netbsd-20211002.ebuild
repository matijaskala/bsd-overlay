# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs vcs-snapshot

DESCRIPTION="A stream editor from NetBSD"
HOMEPAGE="https://www.netbsd.org"
SRC_URI="https://github.com/matijaskala/${PN}/archive/977148cc37f80e3f0e58042474f5940727aea8c1.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="userland_GNU"
RESTRICT="mirror"

DEPEND="dev-libs/libbsd"
RDEPEND="${DEPEND}
	!sys-freebsd/freebsd-ubin
	userland_GNU? ( !sys-apps/sed )"

src_prepare() {
	default

	tc-export CC
}
